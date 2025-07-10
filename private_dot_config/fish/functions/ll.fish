function ll --wraps='ls -lah --color=never' --wraps='eza --color=never -l' --description 'alias ll=eza --color=never -l'
  eza --color=never -l $argv
        
end
