FactoryGirl.define do
  factory :user do
    username     "uzer"
    email    "uzer@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :user2 do
    username     "uzer2"
    email    "uzer2@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :story do
    title "The Raven"
    body "Once upon a midnight dreary, while I pondered weak and weary,
Over many a quaint and curious volume of forgotten lore,
While I nodded, nearly napping, suddenly there came a tapping,
As of some one gently rapping, rapping at my chamber door.
`'Tis some visitor,' I muttered, `tapping at my chamber door -
Only this, and nothing more.'

Ah, distinctly I remember it was in the bleak December,
And each separate dying ember wrought its ghost upon the floor.
Eagerly I wished the morrow; - vainly I had sought to borrow
From my books surcease of sorrow - sorrow for the lost Lenore -
For the rare and radiant maiden whom the angels name Lenore -
Nameless here for evermore.

And the silken sad uncertain rustling of each purple curtain
Thrilled me - filled me with fantastic terrors never felt before;
So that now, to still the beating of my heart, I stood repeating
`'Tis some visitor entreating entrance at my chamber door -
Some late visitor entreating entrance at my chamber door; -
This it is, and nothing more,'

Presently my soul grew stronger; hesitating then no longer,
`Sir,' said I, `or Madam, truly your forgiveness I implore;
But the fact is I was napping, and so gently you came rapping,
And so faintly you came tapping, tapping at my chamber door,
That I scarce was sure I heard you' - here I opened wide the door; -
Darkness there, and nothing more."
    user
  end

  # factory :storywithlimits do
  #   title "Moby Dick"
  #   body "Call me Ishmael. Some years ago—never mind how long precisely
  #   —having little or no money in my purse, and nothing particular to 
  #   interest me on shore, I thought I would sail about a little and see 
  #   the watery part of the world. It is a way I have of driving off the 
  #   spleen, and regulating the circulation. Whenever I find myself growing 
  #   grim about the mouth; whenever it is a damp, drizzly November in my 
  #   soul; whenever I find myself involuntarily pausing before coffin 
  #   warehouses, and bringing up the rear of every funeral I meet; and 
  #   especially whenever my hypos get such an upper hand of me, that it 
  #   requires a strong moral principle to prevent me from deliberately 
  #   stepping into the street, and methodically knocking people's hats 
  #   off—then, I account it high time to get to sea as soon as I can."
  #   lower_limit 20
  #   upper_limit 50
  #   user
  # end
end