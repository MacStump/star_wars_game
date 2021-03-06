include Math

class TieFighter

	attr_accessor :tie_laser, :x, :y, :z
	SHOOT_DELAY = 100

	def initialize
		@tie_fighter_image = Gosu::Image.new(
												 	$window,
												 	'art/tie_fighter2.png'
												 )
		@x = rand(720)
		@y = 0
		@z = 1
		@alive = true

		# random speed and flight path
		@speed = rand(9..13)
		@flight_path = rand(1..3)

		@last_shot = 0
		sound.play
	end

	def update
		@y += +@speed


		#random flight path
		if @flight_path == 1
			@x += sin(Time.now.to_f)*7
		elsif @flight_path == 2
			@x += cos(Time.now.to_f)*7
		end

		if rand(1..60) == 1
			shoot
		end
		if @tie_laser
			@tie_laser.update
		end
	end

	def draw
		unless self.dead?
			@tie_fighter_image.draw(@x,@y,@z,0.5,0.5)
			if @tie_laser
				@tie_laser.draw
			end
		end
	end

	def shoot
		if Gosu.milliseconds - @last_shot > SHOOT_DELAY
			@last_shot = Gosu.milliseconds
			@tie_laser = TieFighterLaser.new(@x,@y)
		end
	end

	def hitbox
		unless self.dead?
			hitbox_x = ((@x - 35).to_i..(@x + 35).to_i).to_a
			hitbox_y = ((@y - 35).to_i..(@y + 35).to_i).to_a
			{x: hitbox_x, y: hitbox_y}
		end
	end

	def kill
	  @alive = false
	end

	def dead?
		!@alive
	end

	def sound
		@@sound = Gosu::Sample.new(
								$window,
								"sound/tie_fly_#{rand(1..6)}.wav"
							)
	end


end