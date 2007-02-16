require 'ramaze'

include Ramaze

class MainController < Controller
  helper :cache

  trait :cached_actions => [:index]

  def index
    calc = "100_000 ** 100_00"
    %[
      Hello, i'm a little method with this calculation:
      #{calc} = #{eval(calc)}
    ]
  end

  def invalidate
    uncache_all
  end
end

run
