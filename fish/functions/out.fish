function out

  if count $argv > /dev/null

    set -l FILE $argv[1]

    if not test -f $FILE
      set_color red
      echo "Error: El archivo '$FILE' no existe."
      set_color normal
      return 1
    end

    set -l BASENAME (string split -r -m1 . $argv[1])[1]
    set -l EXT (string split -r -m1 . $FILE)[2]
    set -l OUTPUT_FILE $BASENAME"_output.txt"
    set EXIT_CODE 0 

    if not test -d  salidas 
      mkdir salidas
    end

    switch $EXT
      case py
        echo ">> python3 $FILE"\n > $OUTPUT_FILE
        python3 $FILE >> salidas/$OUTPUT_FILE 2>&1
        set EXIT_CODE $status
      case f90 f95 f
        # Compile and excute Fortran
        echo ">> ./$BASENAME.out"\n > $OUTPUT_FILE
        if gfortran $FILE -o $BASENAME.out
          ./$BASENAME.out >> salidas/$OUTPUT_FILE 2>&1
          set EXIT_CODE $status
        else
          set EXIT_CODE 1 
        end
      case '*'
        set_color red
        echo "Error: Extensión .$EXT no soportada."
        set_color normal
        return 1
    end

    if test $EXIT_CODE -eq 0
      set_color green
      echo "Salida guardada en salidas/$OUTPUT_FILE"
      set_color normal
    else
      set_color red
      echo "ERROR: Revisa salidas/$OUTPUT_FILE"
      set_color normal
    end

    else
      echo "Uso: out archivo.py o archivo.f90"
      return 2
  end
end
