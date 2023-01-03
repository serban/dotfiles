function workdays --wraps days
  days \
    --exclude ~/src/private/calendar/holidays.txt \
    --exclude ~/src/private/calendar/vacations.txt \
    --exclude ~/src/private/calendar/oncall.txt \
    --exclude-weekends \
    $argv
end
