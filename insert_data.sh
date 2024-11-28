#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.


tail -n +2 games.csv | while IFS="," read -r year round winner opponent winner_goals opponent_goals 
do  
  echo $opponent;
  $PSQL "INSERT INTO teams(name) VALUES('$opponent')"
  $PSQL "INSERT INTO teams(name) VALUES('$winner')"

  WinnerID=$($PSQL "SELECT team_id FROM teams WHERE name='$winner'")
  OpponentID=$($PSQL "SELECT team_id FROM teams WHERE name='$opponent'")

  $PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES
  ('$year', '$round', '$WinnerID', '$OpponentID', '$winner_goals', '$opponent_goals')"


done