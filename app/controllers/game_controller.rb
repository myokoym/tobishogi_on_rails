class GameController < ApplicationController
  def index
    @state ||= "222000111"
  end

  def move
    state = params[:state]
    unless state
      @state = "入力を間違えてるわ"
      render :action => :index
      return
    end
    status = state.split(//)
    @state = catch(:done) {
      8.downto(6) do |i|
        if status[i] == "1"
          if status[i - 3] == "2"
            status[i], status[i - 6] = status[i - 6], status[i]
            throw :done, status.join
          end
        end
      end
      8.downto(3) do |i|
        if status[i] == "1"
          if status[i - 3] == "0"
            status[i], status[i - 3] = status[i - 3], status[i]
            throw :done, status.join
          end
        end
      end
    }
    @state ||= status.join
    render :action => :index
  end
end
