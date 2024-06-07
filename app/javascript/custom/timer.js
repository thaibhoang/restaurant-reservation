document.addEventListener("DOMContentLoaded", () => {
  let countdownElement = document.querySelector('#countdown');
  let createdAt = new Date(countdownElement.dataset.createdAt).getTime();
  let currentTime = new Date().getTime();
  let timeLeft = 1000 * 60 * 5 - (currentTime - createdAt);
  let saveButton = document.querySelector('#save-button');

  let countdownInterval = setInterval(() => {
    if (timeLeft <= 0) {
      clearInterval(countdownInterval);
      countdownElement.textContent = "0:00 minutes. Your holding time has expired";
      saveButton.disabled = true;
    } else {
      let minutes = Math.floor((timeLeft % (1000 * 60 * 60)) / (1000 * 60));
      let seconds = Math.floor((timeLeft % (1000 * 60)) / 1000);
      let formattedSeconds = seconds.toString().padStart(2, '0');

      countdownElement.textContent = `${minutes}:${formattedSeconds} minutes`;
      timeLeft -= 1000;
    }
  }, 1000);
});