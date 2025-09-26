import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets =["divmsgs", "divchats", "msgcontainer"];

  showMessages(e) {
    const chatId = e.currentTarget.dataset.chatId;

    fetch(`/chats/${chatId}/messages`, {
      headers: { "Accept": "text/html" }
    })
      .then(res => res.text())
      .then(html => {
        this.msgcontainerTarget.innerHTML = html;
        this.divmsgsTarget.classList.remove("d-none")
        this.divchatsTarget.classList.add("d-none")
      })
      .catch(err => console.error(err))
  }

  showChats(e) {
    e.preventDefault();
    this.divchatsTarget.classList.toggle("d-none");
    this.divmsgsTarget.classList.toggle("d-none");
    this.msgcontainerTarget.innerHTML = "";
  }
}
