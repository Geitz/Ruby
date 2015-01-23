#!/usr/bin/env ruby
require 'digest/sha1'

class	Hashcash
	def mint(ressources, bits=20, now=nil, ext="", saltchar=8, stamp_seconds = true)
		ts =""
		challenge = ""
		ver = 1
		now = Time.now()
		ts = now.to_s
		ts.gsub!("-", ':')
		ts = ts[0, 19]
		ts.gsub!(" ", ':')
		puts "TIME = " + ts
		challenge = ver.to_s + bits.to_s + ts + ressources + ext + _salt(saltchar)
    	return challenge + _mint(challenge, bits);
	end

	def _salt (length)
		chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ'	## init chars (tableau des caracteres possibles
  		password = ''												## init password
  		length.times { password << chars[rand(chars.size)] }		## Repete 'length' fois le processus: charge dans password un char randomizé
  		return password												## Retourne le password obtenu
	end

	def _mint(challenge, bits)
		counter = 0
		hex_digits = bits / 4
		hex_digits = hex_digits.ceil
		zeros = ""
		hex_digits.times { zeros << "0"}

		while true
			my_sha1 = 	Digest::SHA1.hexdigest (challenge+counter.to_s(16))
			digest = my_sha1.to_s
			if digest[0, hex_digits] == zeros
				puts "----- digest is :" + digest
				return counter.to_s(16)
			else
				counter += 1
			end
		end
	end
end

if __FILE__ == $0
	mHashcash = Hashcash.new

	msg = mHashcash.mint("test")
	puts "mint final = " + msg
end


##my_sha1 = SHA1(mon_challenge)
##if (my_sha1.substr(0, longueur_attend) == "0" * longueur_attend)
##return counter
##sinon counter++