require 'minitest/autorun'
require_relative 'bavard.rb'

class TestBavard < Minitest::Test
  # Entrée: Liste de tweets
  #=> [
  #     {nom: "em_hack", tweet: "Bonjour"},
  #     {nom: "simplonvillage", tweet: "Aprendre à coder en s'ammusant"},
  #     {nom: "em_hack", tweet: "tec tice tec...BOOM!"}
  #   ]
  # Sortie: Liste des auteurs du plus au moins bavard
  #=> { em_hack: 2, simplonvillage: 1 }
  def test_true
    assert true
  end

  def test_retourne_vide_pour_liste_vide
    liste_tweets = []
    assert_equal 0, le_plus_bavard(liste_tweets).count
  end

  def test_pour_un_tweet
    liste_tweets = [{nom: "em_hack", tweet: "Bonjour"}]
    assert_equal 1, le_plus_bavard(liste_tweets).count
    assert_equal :em_hack, le_plus_bavard(liste_tweets).keys.first
    assert_equal 1, le_plus_bavard(liste_tweets).values.first
  end

  def test_pour_deux_tweets_de_2_auteurs
    liste_tweets = [{nom: "em_hack", tweet: "Bonjour"},
                    {nom: "jean", tweet: "Ahoy !"}
                   ]
    assert_equal 2, le_plus_bavard(liste_tweets).count
    assert_equal [:em_hack, :jean], le_plus_bavard(liste_tweets).keys
    assert_equal [1, 1], le_plus_bavard(liste_tweets).values
  end

  def test_pour_deux_tweets_du_mm_auteur
    liste_tweets = [{nom: "em_hack", tweet: "Bonjour"},
                    {nom: "em_hack", tweet: "Ahoy !"}
                   ]
    assert_equal 1, le_plus_bavard(liste_tweets).count
    assert_equal [:em_hack], le_plus_bavard(liste_tweets).keys
    assert_equal [2], le_plus_bavard(liste_tweets).values
  end
end
