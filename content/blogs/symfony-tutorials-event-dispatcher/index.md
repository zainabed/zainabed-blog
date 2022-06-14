---
title: "Symfony Tutorials Event Dispatcher"
date: 2014-10-03T05:28:55-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.jpg"
  alt: "Symfony Tutorials Event Dispatcher"
categories: 
  - "PHP"
  
---


## Introduction

Symfony EventDispatcher is object which interacts with different set of objects when certain event happens.

To illustrate Event Dispatcher definition let’s consider the online shopping website example.

suppose you want to purchase a mobile from online shopping website , but unfortunately that mobile is out of stock.

Then you subscribe into online shopping website for this mobile availability.

When mobile comes in stock, online shopping website notifies you about mobile phone’s availability via email.

In above scenario


- you are the **Event Listener / Event Subscriber**
- mobile availability is **Event**
- online shopping website is **Event Dispatcher**.



Symfony EventDispatcher works in same manner.for example, whenever there is HTTP request, Kernel creates a request object and it dispatches an event ``kernel.request``.

Whoever subscribes to ``kernel.request`` event gets notified.

So here you might be having few questions in my mind.

## What is Event

Event object describe what event is and add some additional information so that its listener or subscriber can get enough information about event.

## What is EventDispatcher

EventDispatcher is central object which dispatches the event to all its listener or subscriber.
EventDispatcher maintains the list of all listeners of a particular Event.

```php
use Symfony\Component\EventDispatcher\EventDispatcher;

$dispatcher =new EventDispatcher();
```

## What is Event Listener

Listener is a object which performs a task whenever a associated event happens. 
But first we need to attach listener to Event Dispatcher for a particular event.

```php
$listener=new MobileAvailabilityListener();
$dispatcher->addListener('store.mobile.available',array($listener,'sendEmailToUsers'));
```
Considering Online Shopping Store example let’s create a custom event and dispatch this event.

Here we want to create mobile availability event which get dispatched whenever mobile is available.

First we create static event class which holds event name and its instance information

Static Event Class

```php
final class MobileEvents
{
    /**
     * The store.mobile.available event is thrown each time when mobile 
     * is available in store
     *
     * The event listener receives an
     * Acme\StoreBundle\Event\MobileAvailableEvent instance.
     *
     * @var string
     */
     const MOBILE_AVAILABLE = 'store.mobile.available';
}
```
 
Later, create actual event object.

Symfony uses ``Symfony\Component\EventDispatcher\Event`` class.

This class wont give us enough information about mobile availability therefor we need to subclass it and add additional information.


```php
namespace Acme\StoreBundle\Event;

use Symfony\Component\EventDispatcher\Event;
use Acme\StoreBundle\Mobile;

class MobileAvailableEvent
{
  protected $mobile;

  public function__construct(Mobile $mobile)
  {
    $this->mobile=$mobile;
  }

  public function getMobile()
  {
    return $this->mobile;
  }
}
```

Later, create event listener, which sends emails to user regarding availability of the mobile phone.

```php
use Acme\StoreBundle\Event\MobileAvailableEvent;

class MobileAvailabilityListener
{
  // ...

  public function sendEmailToUsers(MobileAvailableEvent $event)
  {
     // ... send email to users
  }
}
```


Now all is set, let’s attach this listener to the dispatcher. And dispatch the event.

```php
use Symfony\Component\EventDispatcher\EventDispatcher;
use Acme\StoreBundle\Event\MobileAvailableEvent;
use Acme\StoreBundle\Event\MobileAvailabilityListener;
use Acme\StoreBundle\Entity\Mobile;

$dispatcher = new EventDispatcher();

// attach listener
$listener = new MobileAvailabilityListener();
$dispatcher->addListener(MobileEvents::MOBILE_AVAILABLE, array($listener, 'sendEmailToUsers'));

//if mobile is available then dispatch the event
$mobile = new Mobile();
$event = new MobileAvailableEvent($mobile);
$dispatcher->dispatch(MobileEvents::MOBILE_AVAILABLE, $event);

```
## Conclusion

This is a every basic example, you can create event for user registration process and can send confirmation email via event listener or can do  many things using Symfony Event Dispatcher.