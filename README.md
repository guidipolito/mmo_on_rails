# MMO on Rails
This project is an attempt to make a mmorpg maker platform. Using mostly Ruby.

Client game logic is being developed in Ruby and transpiled to javascript 
by [Opal](https://opalrb.com/) when executing `bin/dev`, only being needed to refresh the window. Graphics 
are being made by wrapping [PIX.js](https://pixijs.com/) lib in Opal

Server game is still to be made and is supposed to have acess to similar data but skiping render phase and visuals.
It's supposed to use It to reinforce rules and validate actions

## License
This content is released under the (http://opensource.org/licenses/MIT) MIT License.
