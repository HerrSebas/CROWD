import Rails from "@rails/ujs";
const initSelfie = () => {
  const video = document.querySelector('.selfie-video');
  const photo = document.querySelector('.selfie-photo');
  const startbutton = document.querySelector('.selfie-startbutton');
  const canvas = document.createElement('canvas');
  let width = 400;    // We will scale the photo width to this
  let height = 0;
  let streaming = false;
  // ////////////
  // /// THE NEW FUNCTION TO TAKE THE SELFIE ⬇️
  // ////////////
  const takePicture = async () => {
    var context = canvas.getContext('2d');
    canvas.width = width;
    canvas.height = height;
    context.drawImage(video, 0, 0, width, height);
    let data = await new Promise((resolve) => {
      canvas.toBlob(resolve, 'image/png');
    });
    // Wrap the selfie and an automated title in a formData
    const formData = new FormData();
    formData.append('selfie[photo]', data, 'selfie.png');
    formData.append('selfie[title]', `Picture taken on ${(new Date).toString()}`);
    // Change the 📸 button to ✅ and freeze the video
    // when the selfie is taken
    startbutton.innerText = "✅";
    video.pause();
    // Send the selfie to Rails backend to store it
    Rails.ajax({
      url: "/selfies",
      type: "post",
      data: formData
    })
  }
  navigator.mediaDevices.getUserMedia({ video: true, audio: false })
    .then(function (stream) {
      video.srcObject = stream;
      video.play();
    })
    .catch(function (err) {
      console.log("An error occurred: " + err);
    });
  video.addEventListener('canplay', function (ev) {
    if (!streaming) {
      height = video.videoHeight / (video.videoWidth / width);
      video.setAttribute('width', width);
      video.setAttribute('height', height);
      canvas.setAttribute('width', width);
      canvas.setAttribute('height', height);
      streaming = true;
    }
  }, false);
  // ////////////
  // /// THE FUNCTION CALL WHEN WE CLICK THE BUTTON ⬇️
  // ////////////
  startbutton.addEventListener('click', (event) => {
    event.preventDefault();
    takePicture();
  });
}
export { initSelfie };
