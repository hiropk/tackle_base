# config/initializers/letter_opener_web.rb
if Rails.env.development?
  LetterOpenerWeb::Engine.routes.draw do
    constraints host: "localhost" do
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
  end
end
