:- use_module(library(lists)).

/* layout of person data item */
person(person(Colour, Nationality, Beverage, Cigar, Pet, Position),
       Colour, Nationality, Beverage, Cigar, Pet, Position).

person_Colour(person(Colour, _Nationality, _Beverage, _Cigar, _Pet, _Position), Colour).
person_Nationality(person(_Colour, Nationality, _Beverage, _Cigar, _Pet, _Position), Nationality).
person_Beverage(person(_Colour, _Nationality, Beverage, _Cigar, _Pet, _Position), Beverage).
person_Cigar(person(_Colour, _Nationality, _Beverage, Cigar, _Pet, _Position), Cigar).
person_Pet(person(_Colour, _Nationality, _Beverage, _Cigar, Pet, _Position), Pet).
person_Position(person(_Colour, _Nationality, _Beverage, _Cigar, _Pet, Position), Position).

colours([red, green, white, yellow, blue]).
nationalities([brit, swede, dane, norwegian, german]).
beverages([tea, coffee, milk, beer, water]).
cigars([pallmall, dunhill, blends, bluemaster, prince]).
pets([dogs, birds, cats, horses, fish]).
positions([1, 2, 3, 4, 5]).

right_of(X, Y) :- X is Y+1.
left_of(X, Y) :- right_of(Y, X).

next_to(X, Y) :- right_of(X, Y).
next_to(X, Y) :- left_of(X, Y).

solution(Persons) :-

/*
Solution contains the person data items for
each person in the puzzle
*/
    Persons = [Brit, Swede, Dane, Norwegian, German],

    /*
    Setting up known values
    */
    person(Brit, BritColour, brit, BritBeverage, BritCigar, BritPet, BritPosition),
    person(Dane, DaneColour, dane, DaneBeverage, DaneCigar, DanePet, DanePosition),
    person(Swede, SwedeColour, swede, SwedeBeverage, SwedeCigar, SwedePet, SwedePosition),
    person(Norwegian, NorwegianColour, norwegian, NorwegianBeverage, NorwegianCigar, NorwegianPet, NorwegianPosition),
    person(German, GermanColour, german, GermanBeverage, GermanCigar, GermanPet, GermanPosition),
    colours(Colours),
    beverages(Beverages),
    cigars(Cigars),
    pets(Pets),
    positions(Positions),

    %% Clues
    %% the Brit lives in the red house
    person_Colour(Brit, red),

    %% the Swede keeps dogs as pets
    person_Pet(Swede, dogs),

    %% the Dane drinks tea
    person_Beverage(Dane, tea),

    %% the green house is on the left of the white house
    person_Colour(White, white),
    member(White, Persons),
    person_Position(White, WhitePosition),
    person_Colour(Green, green),
    member(Green, Persons),
    person_Position(Green, GreenPosition),
    member(GreenPosition, Positions),
    member(WhitePosition, Positions),
    left_of(GreenPosition, WhitePosition),

    %% the green house’s owner drinks coffee
    person_Beverage(Green, coffee),

    %% the person who smokes Pall Mall rears birds
    person_Cigar(PallMall, pallmall),
    member(PallMall, Persons),
    person_Pet(PallMall, birds),

    %% the owner of the yellow house smokes Dunhill
    person_Cigar(Dunhill, dunhill),
    member(Dunhill, Persons),
    person_Colour(Dunhill, yellow),

    %% the man living in the center house drinks milk
    person_Position(Three, 3),
    member(Three, Persons),
    person_Beverage(Three, milk),

    %% the Norwegian lives in the first house
    person_Position(Norwegian, 1),

    %% the man who smokes blends lives next to the one who keeps cats
    person_Cigar(Blends, blends),
    member(Blends, Persons),
    person_Position(Blends, BlendsPosition),
    member(BlendsPosition, Positions),
    person_Pet(Cats, cats),
    member(Cats, Persons),
    person_Position(Cats, CatsPosition),
    member(CatsPosition, Positions),
    next_to(CatsPosition, BlendsPosition),

    %% the man who keeps horses lives next to the man who smokes Dunhill
    person_Pet(Horses, horses),
    member(Horses, Persons),
    person_Position(Horses, HorsesPosition),
    member(HorsesPosition, Positions),
    person_Position(Dunhill, DunhillPosition),
    member(DunhillPosition, Positions),
    next_to(HorsesPosition, DunhillPosition),

    %% the owner who smokes BlueMaster drinks beer
    person_Cigar(BlueMaster, bluemaster),
    member(BlueMaster, Persons),
    person_Beverage(BlueMaster, beer),

    %% the German smokes Prince
    person_Cigar(German, prince),

    %% the Norwegian lives next to the blue house
	person_Colour(Blue, blue),
    member(Blue, Persons),
    person_Position(Blue, BluePosition),
    member(BluePosition, Positions),
    member(NorwegianPosition, Positions),
    next_to(BluePosition, NorwegianPosition),

    %% the man who smokes blend has a neighbor who drinks water
    person_Beverage(Water, water),
    member(Water, Persons),
    person_Position(Water, WaterPosition),
    member(WaterPosition, Positions),
    next_to(WaterPosition, BlendsPosition),

    permutation(Colours, [BritColour, DaneColour, SwedeColour, NorwegianColour, GermanColour]),
    permutation(Beverages, [BritBeverage, DaneBeverage, SwedeBeverage, NorwegianBeverage, GermanBeverage]),
    permutation(Cigars, [BritCigar, DaneCigar, SwedeCigar, NorwegianCigar, GermanCigar]),
    permutation(Pets, [BritPet, DanePet, SwedePet, NorwegianPet, GermanPet]),
    permutation(Positions, [BritPosition, DanePosition, SwedePosition, NorwegianPosition, GermanPosition]).

ownerOfFish(Persons, FishOwner):-
    nth0(_, Persons, person(_, FishOwner, _, _, fish, _)).














