# Typey Jose

[Newgrounds](https://www.newgrounds.com/portal/view/996198), [Itch.io](https://jowain.itch.io/typey-jose)

This was my first ever personal project, my introduction to the Godot Game Engine, and the origin of my love for game development

This is a Flappy-like Typing Game. Rather than just single inputs, you must type quotes from my friend Jose to make him fly.

I originally was making a straight Flappy Bird clone to learn the engine, and then I was struck with inspiration to turn it into a typing game. I got assistance from my friend Jose, as he is the face of the game, the voice actor (as himself), and the originator of the quotes in the game

# Technical Notes
As of writing this (September 2025), Typey Jose was developed over a year ago. The programming is really bad. I did some refactoring to fix some egregious issues:
* The pipes in the game were never destroyed, so eventually the game would crash due to overflow
  
* Various deeply questionable dependencies between game scenes
  
* My recoloring system for the typed text was not a recoloring system. I just overlaid red colored text over the black text to give the illusion of recoloring, and the autowrap wouldn't kick in until the word was fully typed so it looked terrible. It has now been fixed to use... HTML tags. High level stuff

Despite these fixes, the code is still not great. I'm putting it up as a nice look back on how my first real project went. Despite its flaws I still love it like a child

Also please ignore the file organization, I didn't learn what that was yet. I only don't clean it up because I don't want to mess up the spaghetti

