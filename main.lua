-- Title: Numeric TextField
-- Name: Nice Mena
-- course: ICS20/3C
-- this program displays a math question and asks the user to answer in a numeric textfield
-- teminal

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Sets the background colour
display.setDefault("background",177/255, 66/255, 199/255)

---------------------------------------------------------------------------------------------
-- 	LOCAL VARIABLES 
---------------------------------------------------------------------------------------------
-- create local local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local points
local randomOperator
local incorrectObject

---------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
---------------------------------------------------------------------------------------------
local function AskQuestion ()
    -- generate 2 random numbers between a amax an a min number
    randomNumber1 = math.random(0, 10)
    randomNumber2 = math.random(0, 10)
    randomOperator = math.random (1, 3)

    -- create a question in the text object


    -- addition
    if ( randomOperator == 1) then
        -- display the addition question
        questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
        -- calculation the correct answer
        correctAnswer = randomNumber1 + randomNumber2

    -- subtraction
    elseif ( randomOperator == 2) then
        questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
        correctAnswer = randomNumber1 - randomNumber2

            if (correctAnswer < 0) then 
                questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
                correctAnswer = randomNumber2 - randomNumber1
            end

    -- multiplication
    elseif ( randomOperator == 3) then
        questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "
        correctAnswer = randomNumber1 * randomNumber2

    end
end


local function HideCorrect()
    correctObject.isVisible = false
    AskQuestion()
end

local function HideIncorrect()
    incorrectObject.isVisible = false
end    

local function NumericFieldlistener(event)
	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

	-- clear text field 
	event.target.text = ""

   elseif event.phase == "submitted" then 

   	-- when the answer is is submitted (enter jey is pressed) set user input to user's answer

   userAnswer = tonumber(event.target,text)

   -- if the user's answer and the correct answer are the same: 
      if (userAnswer == correctAnswer) then
      	correctObject.isVisible = true
      	timer.performWithDelay(2000, HideCorrect)
       
       elseif (userAnswer ~= correctAnswer) then 
          incorrectObject.isVisible = true
          timer.performWithDelay(2000, HideIncorrect)
      end
   end
end

---------------------------------------------------------------------------------------------
-- OBJECT CREATION
---------------------------------------------------------------------------------------------
-- displays a question and sets the colour
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject:setTextColor(100/255, 96/255, 225/255)
correctObject = display.newText("correct", display.contentWidth/4, display.contentHeight/3, nil, 50)
incorrectObject = display.newText("incorrect", display.contentWidth/4, display.contentHeight/3, nil, 50)

-- Create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldlistener)


-- CALL THE FUNCTION
AskQuestion()