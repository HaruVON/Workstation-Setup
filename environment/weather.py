#!/usr/bin/env python3
# Script to handle a multicolumn display of calendar and weather
# Highlights current day in calendar, and fetches the weather via wttr.in URL
# Currently no smarts, no location awareness, just hardcoded value of city
# Author: D. Kevin McGrath (d.kevin_mcgrath@mcafee.com)
# Last Update: September 12, 2019  

import calendar
import datetime
import requests

FG = '\033[0;32;1;7m'
NC = '\033[0m'

def get_calendar():
    today = datetime.datetime.today()

    day = today.day
    month = today.month
    year = today.year

    cal = calendar.TextCalendar(6).formatmonth(year, month)
    
    tl = cal.find(str(day), cal.find('\n'))

    return (cal[:tl] + FG + cal[tl:tl+len(str(day))] + NC + cal[tl+len(str(day)):]).split('\n')

def get_weather():
    url = 'http://wttr.in/Hillsboro?days=0'
    weather = requests.get(url).text
    return weather.split('\n')[1:]

def intro(calendar, weather):
    shorter = min(len(weather), len(calendar))
    longer = max(len(weather), len(calendar))
    
    for i in range(shorter):
        print(calendar[i] + '\t\t' + weather[i])

    for i in range(shorter, longer):
        if len(calendar) > shorter:
            print(calendar[i])
        else:
            print(weather[i])

def main():
    calendar = get_calendar()
    weather = get_weather()
    intro(calendar, weather)

if __name__ == '__main__':
    main()
                
