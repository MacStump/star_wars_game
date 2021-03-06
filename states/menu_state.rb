require 'singleton'

class MenuState < GameState
	include Singleton
	attr_accessor :play_state

	def initialize
		$window.caption = 'Star Wars Game'

		#images
		@background = Gosu::Image.new($window,'art/starry_background.png')
		@title = Gosu::Image.new($window,'art/sw_title.png')

		# menu options
		@menu_options = Gosu::Image.from_text($window,'Press Escape to Quit, Press N to start a New Game',Gosu.default_font_name,30)

		#controls text
		@controls_header = Gosu::Image.from_text($window,'Controls:',Gosu.default_font_name,30)
		@w_text = Gosu::Image.from_text($window,'W = Up',Gosu.default_font_name,20)
		@a_text = Gosu::Image.from_text($window,'A = Left',Gosu.default_font_name,20)
		@s_text = Gosu::Image.from_text($window,'S = Down',Gosu.default_font_name,20)
		@d_text = Gosu::Image.from_text($window,'D = Right',Gosu.default_font_name,20)
		@l_text = Gosu::Image.from_text($window,'L = Fire Laser Cannons',Gosu.default_font_name,20)

		#rules
		@rules_text = Gosu::Image.from_text($window, 'Shoot the TIE Fighters to score points. Avoid enemies and their lasers to survive!',Gosu.default_font_name,20)

		#info
		@info_text = Gosu::Image.from_text($window, 'Created by Dan Le Cornu, code can be found at https://github.com/MacStump/star_wars_game',Gosu.default_font_name,20)

		#high score
		# @high_score = Gosu::Image.from_text($window, "High Score: #{$scores.max}",Gosu.default_font_name,20)

	end

	def enter
		music.play
		music.volume = 0.6
	end

	def leave
		music.volume = 0
		music.stop
	end

	def music
		@@music ||= Gosu::Song.new(
									$window,
									'sound/sw_theme.mp3'
								)
	end

	# button inputs
	def button_down(id)

		$window.close if id == Gosu::KbEscape
		$window.close if id == Gosu::KbQ

		# if C is pressed and playstate is active, continue game
		if id == Gosu::KbC && @play_state
			GameState.switch(@play_state)
		end

		# if N is pressed, new game
		if id == Gosu::KbN
			@play_state = PlayState.new
			GameState.switch(@play_state)
		end

	end

	def update

		# position for title
		@title_x = $window.width/2 - @title.width/2
		@title_y = @title.height/2

		# position for background
		@background_x = 0
		@background_y = 0
		@background_fx = 1
		@background_fy = 1.5

		# position for menu options
		@menu_options_x = $window.width/2 - @menu_options.width/2
		@menu_options_y = $window.height/2 - @menu_options.height/2 - 200

		# position for control texts
		@controls_header_x = $window.width/2 - @controls_header.width/2
		@controls_header_y = $window.height/2 - @controls_header.height/2 -100

		# position for w
		@w_text_x = $window.width/2 - @w_text.width/2
		@w_text_y = $window.height/2 - @w_text.height/2 - 50

		# position for a
		@a_text_x = $window.width/2 - @a_text.width/2
		@a_text_y = $window.height/2 - @a_text.height/2 - 25

		# position for s
		@s_text_x = $window.width/2 - @s_text.width/2
		@s_text_y = $window.height/2 - @s_text.height/2

		# position for d
		@d_text_x = $window.width/2 - @d_text.width/2
		@d_text_y = $window.height/2 - @d_text.height/2 + 25

		# position for l
		@l_text_x = $window.width/2 - @l_text.width/2
		@l_text_y = $window.height/2 - @l_text.height/2 + 75

		# position for rules
		@rules_text_x = $window.width/2 - @rules_text.width/2
		@rules_text_y = $window.height/2 - @rules_text.height/2 + 150

		# position for high score
		# @high_score_x = $window.width/2 - @high_score.width/2
		# @high_score_y = $window.height/2 - @high_score.height/2 + 250

		# position for info text
		@info_text_x = $window.width/2 - @info_text.width/2
		@info_text_y = $window.height - @info_text.height/2 - 25

	end

	def draw
		@background.draw(@background_x,@background_y,0,@background_fx,@background_fy)

		@title.draw(@title_x,@title_y,1)

		@menu_options.draw(@menu_options_x,@menu_options_y,0)

		@controls_header.draw(@controls_header_x,@controls_header_y,1)
		@w_text.draw(@w_text_x,@w_text_y,1)
		@a_text.draw(@a_text_x,@a_text_y,1)
		@s_text.draw(@s_text_x,@s_text_y,1)
		@d_text.draw(@d_text_x,@d_text_y,1)
		@l_text.draw(@l_text_x,@l_text_y,1)

		@rules_text.draw(@rules_text_x,@rules_text_y,1)

		# @high_score.draw(@high_score_x,@high_score_y,1)

		@info_text.draw(@info_text_x,@info_text_y,1)


	end

end

