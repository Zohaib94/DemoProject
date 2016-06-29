ACTORS = [
          ['Tom', 'Cruise', 'Male', 'USA', 'New York', '1994-12-04',  'Tom Cruise is an American actor and filmmaker. Cruise has been nominated for three Academy Awards and has won three Golden Globe Awards. He started his career at age 19 in the 1981 film Endless Love'],
          ['Johnny', 'Depp', 'Male', 'USA', 'New York', '1994-12-04' , 'John Christopher "Johnny" Depp II is an American actor, producer, and musician. He has won the Golden Globe Award and Screen Actors Guild Award for Best Actor.'],
          ['Russell', 'Crowe', 'Male', 'USA', 'New York', '1994-12-04', 'Russell Ira Crowe is a New Zealand actor, film producer and musician. Although a New Zealander and New Zealand citizen, he has lived most of his life in Australia and identifies himself as an Australian.'],
          ['Brad', 'Pitt', 'Male', 'USA', 'New York', '1994-12-04', 'William Bradley "Brad" Pitt is an American actor and producer. He has received a Golden Globe Award, a Screen Actors Guild Award, and three Academy Award nominations in acting categories'],
          ['Angelina', 'Jolie', 'Female', 'USA', 'New York', '1994-12-04', 'Angelina Jolie Pitt is an American actress, filmmaker, and humanitarian. She has received an Academy Award, two Screen Actors Guild Awards, and three Golden Globe Awards, and has been cited as Hollywood highest-paid actress'],
         ]

ACTORS.each do |actor|
  Actor.where(first_name: actor[0], last_name: actor[1]).first_or_create(gender: actor[2], country: actor[3], city: actor[4], birth_date: actor[5], biography: actor[6])
end
