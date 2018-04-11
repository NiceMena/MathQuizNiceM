-- Title: Math quiz
-- Name: Nice Mena
-- course: ICS20/3C
-- this program displays a math question and asks the user for the answer and it also displays lives and a timer

display.setStatusBar(display.HiddenStatusBar)

--set the background colour
local background = display.newImageRect("Images/numberbkg.png", 2200, 900)
background.x = 200
background.y = 400

background:toBack()
------------------------------------------------------------------------------------------------------------------------------------
--LOCAL VARIABLES
------------------------------------------------------------------------------------------------------------------------------------
--create local variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local randomNumber3
local randomNumber4
local userAnswer
local correctAnswer
local userAnswer
local correctAnswer
local correctAnswerObject
local totalSeconds = 10
local secondsLeft = 10
local clockText
local countDownTimer
local lives = 3
local heart1  
local heart2  
local heart3 
local points = 0
local pointsObject
local randomOperator
local gameOver
local winscreen


------------------------------------------------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------
local function AskQuestion()

 -- generate 2 random numbers between a max. and a min. number
  randomNumber1 = math.random(0, 20)
  randomNumber2 = math.random(0, 20)
  randomNumber3 = math.random(1, 10)
  randomNumber4 = math.random(1, 10)
  randomOperator = math.random(1, 4)

  if (randomOperator == 1) then
  correctAnswer = randomNumber1 + randomNumber2

    --create question in text object

 questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "


 elseif (randomOperator == 2) then
  correctAnswer = randomNumber1 - randomNumber2
    
    --create question in text object

    questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
    if (correctAnswer <0) then
      correctAnswer = randomNumber2 - randomNumber1
      questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "


  elseif (randomOperator == 3) then
    correctAnswer = randomNumber3 * randomNumber4

    --create question in text object

 questionObject.text = randomNumber3 .. " X " .. randomNumber4 .. " = "


  elseif (randomOperator == 4) then
  correctAnswer = randomNumber3 * randomNumber4
  randomNumber3 = correctAnswer
  correctAnswer = randomNumber3 / randomNumber4

  -- create question in text object
  
  questionObject.text = randomNumber3 .. " / " .. randomNumber4 .. " = " 

   end
end

local function StopTimer(event)

  if (lives == 0) then

  timer.cancel(countDownTimer)

  elseif (points == 5) then

    timer.cancel(countDownTimer)

  end

end

----------------------------------------------------------------------------------------
--OBJECT CREATION
--------------------------------------------------------------------------
-- create the objects (heart)

local function UpdateHearts()

  if (lives == 3) then

    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = true


  elseif (lives == 2) then

    heart1.isVisible = true
    heart2.isVisible = true
    heart3.isVisible = false


  elseif (lives == 1) then


    heart1.isVisible = true
    heart2.isVisible = false
    heart3.isVisible = false


  elseif (lives == 0) then

    heart1.isVisible = false
    heart2.isVisible = false
    heart3.isVisible = false
    gameOver.isVisible = true


    StopTimer()

    numericField.isVisible = false
    questionObject.isVisible = false
    pointsObject.isVisible = false
    clockText.isVisible = false
    incorrectObject.isVisible = false

  end

end

local function UpdateTime()

  --decrement the number of seconds 
  secondsLeft = secondsLeft - 1

  --display the number of seconds left in the clock object

  clockText.text = secondsLeft .. ""

  if (secondsLeft == 0) then

    --reset the number of seconds

    secondsLeft = totalSeconds

    lives = lives -1


    UpdateHearts()

  end 

end

local function StartTimer()

  -- create a countdown timer that loops indefinetly

  countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)

end

local function HideCorrect()

  correctObject.isVisible = false

  AskQuestion()

end

local function HideIncorrect()

  incorrectObject.isVisible = false

  AskQuestion()

end

local function NumericFieldListener( event )

  --User begins editing "numericField"

  if ( event.phase == "began" ) then
  elseif ( event.phase == "submitted" ) then

    --when the answer is submitted (enter key is pressed) set user input to user's answer

    userAnswer = tonumber(event.target.text)

    --if the user's answer and the correct answer are the same:

    if (userAnswer == correctAnswer) then
      correctObject.isVisible = true

      timer.performWithDelay(3000, HideCorrect)

      event.target.text = ""

      points = points + 1

      pointsObject.text = "Points:".. points

      secondsLeft = totalSeconds


    else
      lives = lives -1
      UpdateHearts()

      incorrectObject.text = "The correct answer is "..correctAnswer
      incorrectObject.isVisible = true

      timer.performWithDelay(3000, HideIncorrect)

      event.target.text = ""

      secondsLeft = totalSeconds


    end

    if (points == 5) then

      winscreen.isVisible = true
      numericField.isVisible = false

      StopTimer()

    end     

  end

end

------------------------------------------------------------------------------------------------------------------------------------
--OBJECT CREATION
------------------------------------------------------------------------------------------------------------------------------------
--create the lives to display on the screen

heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 7/8
heart1.y = display.contentHeight * 1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 6/8
heart2.y = display.contentHeight * 1/7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 5/8
heart3.y = display.contentHeight * 1/7

--create the gameover screen
gameOver = display.newImageRect("Images/gameOver.png", 1100, 1100)
gameOver.x = 600
gameOver.y = 500
gameOver.isVisible = false

--create the clock object
clockText = display.newText("", 100, 100, Georgia, 55)
clockText:setTextColor(1, 0, 0)

--displays a question and sets the colour

questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/3, nil, 55)
questionObject:setTextColor(155/255, 42/255, 198/255)

--Create the correct text object and make it invisible

correctObject = display.newText( "Correct!", display.contentWidth/1.9, display.contentHeight/2, Georgia, 60)
correctObject:setTextColor(0/255, 0/255, 255/255)
correctObject.isVisible = false

--Create the points text object and make it invisible

pointsObject = display.newText("Points: 0", display.contentWidth/1.9, display.contentHeight*2/3, Georgia, 70)
pointsObject:setTextColor(0/255, 255/255, 0/255)
pointsObject.isVisible = true

--Create the correct text object and make it invisible

incorrectObject = display.newText( "", display.contentWidth/1.9, display.contentHeight/2, Georgia, 60)
incorrectObject:setTextColor(255/255, 0/255, 0/255)
incorrectObject.isVisible = false

--create a numeric field
numericField = native.newTextField( display.contentWidth/1.9, display.contentHeight/3, 170, 80 )

numericField.inputType = "number"

--create a win background

winscreen = display.newImageRect("Images/win.png",  1100, 1100)
winscreen.x = 500
winscreen.y = 400
winscreen.isVisible = false

--add the event listener for the numeric field

numericField:addEventListener( "userInput", NumericFieldListener )

------------------------------------------------------------------------------------------------------------------------------------
--FUNCTION CALLS
------------------------------------------------------------------------------------------------------------------------------------
--call functions

AskQuestion()

UpdateTime()

StartTimer()

end