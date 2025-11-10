-> start

=== start ===
# speaker: Narrator
You are walking through a dense forest when you spot a figure sitting on a fallen log. As you approach, you see it's an old man with a long beard and a twinkle in his eye.

# speaker: Old Man
"Ah, a traveler! What brings you to these woods?"

*   "I'm just passing through."
    -> Just_passing_through
*   "I'm looking for something."
    -> Looking_for_something

=== Just_passing_through ===
# speaker: Old Man
"Passing through, eh? These woods are full of surprises. Best be careful."

*   "What kind of surprises?"
    -> Ask_about_surprises
*   "I can handle myself."
    -> Handle_yourself

=== Ask_about_surprises ===
# speaker: Old Man
"Oh, you know... strange creatures, hidden paths, and the occasional talking tree." He chuckles.

*   "Talking trees? Really?"
    -> Talking_trees
*   "I should keep moving then."
    -> Keep_moving

=== Talking_trees ===
# speaker: Old Man
"Indeed! Just last week, I had a lovely chat with an oak. He was quite the philosopher."

*   "That's amazing! Can I meet one?"
    -> Meet_a_tree
*   "You're pulling my leg."
    -> Pulling_leg

=== Meet_a_tree ===
# speaker: Old Man
"Perhaps, if you listen closely. The trees speak to those who are patient."

*   "I'll try listening."
    -> Listen_to_trees
*   "I don't have time for this."
    -> No_time

=== Listen_to_trees ===
# speaker: Narrator
You sit quietly and listen. At first, there's only the rustling of leaves, but then... a soft whisper.

# speaker: Tree
"Welcome, traveler..."

-> END

=== No_time ===
# speaker: Old Man
"Suit yourself. Safe travels, then."

# speaker: Narrator
You continue on your way, wondering if the old man was telling the truth.

-> END

=== Pulling_leg ===
# speaker: Old Man
"Believe what you will, traveler. But the forest holds many secrets."

# speaker: Narrator
You nod politely and continue on your path.

-> END

=== Keep_moving ===
# speaker: Old Man
"Wise choice. The forest is no place to linger."

# speaker: Narrator
You bid the old man farewell and continue your journey.

-> END

=== Handle_yourself ===
# speaker: Old Man
"Confidence is good, but even the bravest can get lost in these woods."

*   "I'll take my chances."
    -> Take_chances
*   "Maybe you're right."
    -> Maybe_right

=== Take_chances ===
# speaker: Old Man
"Very well. May the forest guide your steps."

# speaker: Narrator
You nod and continue deeper into the woods.

-> END

=== Maybe_right ===
# speaker: Old Man
"A little caution never hurt anyone. Safe travels, friend."

# speaker: Narrator
You thank the old man and head back the way you came.

-> END

=== Looking_for_something ===
# speaker: Old Man
"Looking for something, are you? Perhaps I can help. What is it you seek?"

*   "I'm searching for a lost treasure."
    -> Lost_treasure
*   "I'm looking for a way out of the forest."
    -> Way_out

=== Lost_treasure ===
# speaker: Old Man
"Ah, the treasure of the forest! Many have sought it, but few have found it."

*   "Can you tell me where it is?"
    -> Ask_for_directions
*   "I'll find it on my own."
    -> Find_on_own

=== Ask_for_directions ===
# speaker: Old Man
"Follow the path where the moonlight shines brightest. But beware—the forest guards its secrets well."

*   "Thank you!"
    -> Thank_you
*   "I don't believe you."
    -> Dont_believe

=== Thank_you ===
# speaker: Old Man
"Good luck, traveler. May your journey be fruitful."

# speaker: Narrator
You follow the old man's advice and set off toward the moonlight.

-> END

=== Dont_believe ===
# speaker: Old Man
"Skepticism is healthy, but sometimes the truth is stranger than fiction."

# speaker: Narrator
You shrug and continue your search, unsure of what to believe.

-> END

=== Find_on_own ===
# speaker: Old Man
"Very well. The forest rewards the bold."

# speaker: Narrator
You thank the old man and continue your quest.

-> END

=== Way_out ===
# speaker: Old Man
"The forest can be confusing, but if you follow the river, it will lead you to safety."

*   "Thank you for your help."
    -> Thank_you_way_out
*   "I'll find my own way."
    -> Find_own_way

=== Thank_you_way_out ===
# speaker: Old Man
"You're welcome, traveler. Safe journeys."

# speaker: Narrator
You follow the river and soon find your way out of the forest.

-> END

=== Find_own_way ===
# speaker: Old Man
"As you wish. May your path be clear."

# speaker: Narrator
You decide to trust your instincts and continue walking.

-> END
