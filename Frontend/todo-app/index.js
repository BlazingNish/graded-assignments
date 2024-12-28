var tasks = [];

function addTask(){
    var task = document.getElementById('task').value;
    document.getElementById('task').value = '';
    tasks.push(task);
    displayTasks();
}


function clearTask(taskElement, index){
    taskElement.classList.add("strike");
    taskElement.classList.add("completed");
    tasks.splice(index, 1);
    setTimeout(function(){
        taskElement.remove();
    }, 2000);
}
function displayTasks(){
    const taskDiv = document.getElementById("taskContainer");
    taskDiv.innerHTML = '';
    tasks.forEach(function(task, index){
        const taskElement = document.createElement("div");
        taskElement.addEventListener("click", function(){
            clearTask(taskElement, index);
        });
        taskElement.innerHTML = task;
        taskElement.classList.add("task");
        taskDiv.appendChild(taskElement);
    });
}

var input = document.getElementById("task");

input.addEventListener("keypress", function(event) {
    if(event.key === "Enter"){
        document.getElementById("addButton").click();
    }
})