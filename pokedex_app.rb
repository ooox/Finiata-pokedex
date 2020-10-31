class PokedexApp < Sinatra::Application
  enable :sessions

  get '/' do
    display_page :index
  end

  def display_page(location, locals = {})
    options = {
      layout_options: { views: './views/layouts' },
      layout: locals.fetch(:layout) { :default },
      locals: locals
    }
    get_pokemon
    abilities

    haml location.to_sym, options
  end

  def display_partial(location, locals = {})
    haml location.to_sym, layout: false, locals: locals
  end

  def get_pokemon
    @pokemon ||= PokeApi.get(pokemon: random_id)
    @name = @pokemon.name
    @image = "https://img.pokemondb.net/artwork/large/#{@name}.jpg"
    @weight = @pokemon.weight
    @height = @pokemon.height
    @species = @pokemon.species.name
  end

  def abilities
    @abilities = ""
    @pokemon.abilities.each do |a|
      @abilities << a.ability.name + "<br> "
    end
  end

  def random_id
    rand(1..248)
  end
end
