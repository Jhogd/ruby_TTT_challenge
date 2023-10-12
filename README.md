# ruby_TTT_challenge

### Description
This is an unbeatable tic-tac-toe game that is played in the terminal. You can choose to play as X or O to try and beat the Ai but good luck with that...

### Setup
If you already have Homebrew proceed to Download Ruby if not paste this into your terminal
            
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Next quit and restart your terminal and then run the command

        brew doctor
If you get a message that states "Your system is ready to brew" you are all set up

If you don't then read what Homebrew is saying very carefully, it may ask you to run some commands after installation such as these

        echo "eval $(/opt/homebrew/bin/brew shellenv)" >> ~/.zprofile
        eval $(/opt/homebrew/bin/brew shellenv)
Now restart the terminal and run this command one more time to make sure everything is good to go

        brew doctor

### Download Ruby
With Homebrew installed you can download Ruby
        
        brew install ruby

### Running Tests
Run all spec files in terminal

        ruby run_tests.rb

Run spec file individually

        ruby spec/spec_file_you_want_to_run.rb

### play game

        ruby src/core.rb