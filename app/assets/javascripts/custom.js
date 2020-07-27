/*global $*/

const typing = (element, sentence) => {
  [...sentence].forEach((character, index) => {
    setTimeout(() => {
      document.querySelector(element).textContent += character;
    }, 20* ++index);
  });
}

typing('#typing', " Choose one category and start free writing. Whatever you feel, experience and learned, not only them but something abstract, share with others.If you do not have anything to write, do not worrie about it. After your logg-in, you can see all contents as many as there are. Please do not forget to like and good-comment. Then, reading develops your imagination.");