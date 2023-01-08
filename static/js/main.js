function clearInputOutput() {
    let textareas = document.getElementsByTagName("textarea");
    for (text of textareas) {
        text.value = "";
    }
}