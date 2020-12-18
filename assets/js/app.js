import "../css/app.css"

import "phoenix_html"

// Allow copying links to clipboard
let copyButton = document.querySelector('[data-copy-link]');

copyButton.addEventListener('click', event => {
  // If we don't have access to the clipboard API than just bail out.
  if (!navigator.clipboard) {
    return;
  }

  copyButton.classList.remove('hover:bg-blue-200');
  copyButton.classList.add('copied');
  setTimeout(() => {
    copyButton.classList.remove('copied')
    copyButton.classList.add('hover:bg-blue-200');
  }, 1000);

  try {
    var shortURL = event.srcElement.getAttribute("data-copy-link");
    navigator.clipboard.writeText(shortURL);
  } catch (error) {
    console.error("Failed to copy link to clipboard", error);
  }
});

