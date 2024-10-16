import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="messages"
export default class extends Controller {
  connect() {
    const messageArea = document.querySelector("#new_messages");

    if (messageArea) {
      const observer = new MutationObserver(() => {
        this.replaceMessageCss();
      });

      observer.observe(messageArea, { childList: true });
    }
  }

  replaceMessageCss() {
    const messageForm = document.querySelector("form[data-controller='messages']");
    const userUUID = messageForm.dataset.senderUuid;
    const newMessages = document.querySelectorAll(`.user_${userUUID}`);

    newMessages.forEach((newMessage) => {
      newMessage.classList.remove(`user_${userUUID}`);
      newMessage.classList.add("sent-message");
    });
  }

  clear() {
    this.element.reset();
  }
}
