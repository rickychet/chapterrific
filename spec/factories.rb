FactoryGirl.define do
  factory :user do
    sequence(:username)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
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
end