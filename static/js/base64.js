var mode;

function changeMode(modeName, tabElement) {
    let modeElement = document.getElementsByClassName("modeName")
    for (element of modeElement) {
        element.innerHTML = modeName
    }
    mode = modeName;
    modeElement.innerHTML = modeName

    if (tabElement != null) {
        updateTab(tabElement);
    }
}

function execute() {
    let message = document.getElementById("message");
    message.innerHTML = "";
    if (mode === "encode") {
        let inputElement = document.getElementById("input")
        try {
            let output = btoa(inputElement.value)
            let outputElement = document.getElementById("output")
            outputElement.value = output;
        } catch (error) {
            message.innerHTML = "Invalid input";
        }
    } else {
        try {
            let inputElement = document.getElementById("input")
            let output = atob(inputElement.value)
            let outputElement = document.getElementById("output")
            outputElement.value = output;
        } catch (error) {
            message.innerHTML = "Invalid input";
        }
    }
}

function updateTab(tabElement) {
    let tabs = document.getElementsByClassName("tab");
    for (tab of tabs) {
        tab.classList.remove("tab-active");
    }
    tabElement.classList.add("tab-active");
    clearInputOutput();
}

function clearInputOutput() {
    let textareas = document.getElementsByTagName("textarea");
    for (text of textareas) {
        text.value = "";
    }
}
changeMode("encode")