#!/bin/bash
# removes multiple packages - interactive mode

ok_install="ok installed"
packages=("evolution" "five-or-more" "hitori" "gnome-robots" "gnome-chess" "gnome-sudoku" "gnome-taquin" "gnome-tetravex")
del_flag=0

for p in "${packages[@]}"
    do
      p_check=$(dpkg-query -W --showformat='${Status}\n' $p | grep "ok installed")
      if [[ "$p_check" == *"$ok_install" ]]; then
          echo "uninstalling ... $p"
          apt-get purge $p
          del_flag=1
      else
          echo "$p NOT installed"
      fi
done

if  (( $del_flag==1 )); then
    echo "Remove dependencies..."
    apt-get autoremove
fi
