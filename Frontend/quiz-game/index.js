var questions = [
  {
    question: "What is the capital of France?",
    choices: ["Paris", "London", "Berlin", "Madrid"],
    correctAnswer: 0,
  },
  {
    question: "What is the capital of Spain?",
    choices: ["Paris", "London", "Berlin", "Madrid"],
    correctAnswer: 3,
  },
  {
    question: "Lions belong to which family?",
    choices: ["Canidae", "Ursidae", "Felidae", "Mustelidae"],
    correctAnswer: 2,
  },
  {
    question: "Who is the author of the Harry Potter series?",
    choices: [
      "J.R.R. Tolkien",
      "J.K. Rowling",
      "George R.R. Martin",
      "Stephen King",
    ],
    correctAnswer: 1,
  },
];

var score = 0;
var currQuestion = 0;
var questionBox = document.getElementById("question");

function loadQues() {
  var options = document.getElementById("options");
  var question = questions[currQuestion].question;

  questionBox.innerHTML = question;
  options.innerHTML = "";

  const choices = questions[currQuestion].choices;
  console.log(choices)

  choices.forEach((choice, index) => {
    const choiceDiv = document.createElement("div");
    const choiceInput = document.createElement("input");
    const choiceLable = document.createElement("label");
    choiceInput.type = "radio";
    choiceInput.name = "option";
    choiceInput.value = index;
    choiceInput.classList.add("form-check-input");
    choiceInput.id = `${choice}`;
    choiceDiv.classList.add("options");
    choiceLable.classList.add("form-check-label");
    choiceLable.htmlFor = `${choice}`;
    choiceLable.textContent = choice;
    choiceDiv.appendChild(choiceInput);
    choiceDiv.appendChild(choiceLable);
    options.appendChild(choiceDiv);
  });
}

loadQues();

function nextQuestion() {
  if (currQuestion < questions.length - 1) {
    currQuestion++;
    loadQues();
  }
  else{
    document.getElementById("options").classList.add("hidden");
    document.getElementById("question").classList.add("hidden");
    document.getElementById("btn").classList.add("hidden");
    document.getElementById("restartButton").classList.remove("hidden");
    loadScore();
  }
}

function loadScore(){
  const scoreDiv = document.getElementById("score");
  scoreDiv.textContent = `Your score is ${score} out of ${questions.length}`;
}

function checkAns(){
  const selectedOption = document.querySelector('input[name="option"]:checked').value;

  

  if(selectedOption == questions[currQuestion].correctAnswer){
    score++;
    nextQuestion();
  }
  else{
    nextQuestion();
  }
}
