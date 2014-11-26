require 'pry'

def le_plus_bavard(liste)
  bavards = {}
  noms = liste.map{ |tweet| tweet[:nom].to_sym }
  #=> [:em_hack, :jean, :jean]
  noms.each do |auteur|
    if bavards[auteur]
      bavards[auteur] += 1
    else
      bavards[auteur] = 1
    end
  end
  #=> {em_hack: 1, jean: 2}
  bavards
end

def plus_bavard(liste)
  bavards = {}
  liste.each do |tweet|
    pseudo = tweet[:nom].to_sym
    bavards[pseudo] = bavards[pseudo] ? bavards[pseudo] + 1 : 1
  end
  bavards
end
