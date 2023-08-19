class Public::HomesController < ApplicationController

 def top
  @grants = Grant.all.order(created_at: :desc).limit(9)
 end

end