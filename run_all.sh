#!/bin/bash

OUTDIR="results"
mkdir -p "$OUTDIR"

for DIR in Chapter01 Chapter02; do
  find "$DIR" -maxdepth 3 -type f -executable ! -name '*.cu' | sort | while read BIN; do
    NAME=$(basename "$BIN")
    LOG="$OUTDIR/${NAME}.log"
    echo "=== $NAME ===" > "$LOG"

    # 실행 파일이 있는 디렉토리로 이동
    WORKDIR=$(dirname "$BIN")
    pushd "$WORKDIR" > /dev/null

    # 바이너리만 이름으로 호출
    if ./"$NAME" >> "$OLDPWD/$LOG" 2>&1; then
      echo "Done" >> "$OLDPWD/$LOG"
      echo " -> $NAME: Done"
    else
      echo "Error" >> "$OLDPWD/$LOG"
      echo " -> $NAME: Error (로그 확인)"
    fi

    popd > /dev/null
  done
done
