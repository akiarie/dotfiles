#!/usr/local/bin/python3
# coding: utf-8
import argparse
import datetime
import os
import re
import unicodedata

def shell_cmd(cmd):
    return os.popen(cmd).read()

def date_time():
    def find_time_icon(now):
        hour = (now.hour % 12) # 12-hour time
        minute = now.minute

        # averages
        if minute > 45:
            hour = (hour + 1) % 12

        hour_name = [
            'twelve', # zero-oclock
            'one', 'two', 'three',
            'four', 'five', 'six',
            'seven', 'eight', 'nine',
            'ten', 'eleven',
        ][hour]

        minute_name = [
            ' oclock',
            '-thirty',
        ][15 < minute <= 45]

        name = f'clock face {hour_name}{minute_name}'

        return unicodedata.lookup(name)

    now = datetime.datetime.now()
    date = now.strftime('%a, %d %b')
    time = now.strftime('%H:%M')
    date_icon = '📅'
    time_icon = find_time_icon(now)

    return f' {date_icon} {date} {time_icon} {time} '

def volume():
    vol_left, vol_right = map(int, shell_cmd('mixer -S vol').split(':')[1:])
    vol = int((vol_left + vol_right)/2)
    vol_icon = ['🔇','🔈'][int(vol) > 0]

    return f' {vol_icon} {vol} '

def battery():
    bat = int(shell_cmd('apm -l'))
    charging = bool(int(shell_cmd('apm -a')))
    bat_icon = ['🔋', '🔌'][int(charging)]

    return f' {bat_icon} {bat} '

def light():
    def light_bar(light_amount):
        light_values=[1, 2, 4, 6, 9, 12, 16, 20, 25, 30, 36, 43, 51, 60, 70, 80, 90, 100]
        if light_amount not in light_values:
            return str(light_amount)

        points = light_values.index(light_amount)

        full_bars = points // 7
        tiny_bars = points - full_bars * 7

        bar = full_bars * chr(0x2588) + chr(0x258f - tiny_bars)

        return '{0: <3}'.format(bar)

    raw_light = shell_cmd('intel_backlight')
    try:
        light_amount = int(re.search('[^0-9.]*([0-9]+)%.*', raw_light).group(1))
        light = light_bar(light_amount) 
    except (AttributeError, IndexError):
        light = '?'

    light_icon = '\N{high brightness symbol}'

    return f' {light_icon} {light}'

parser = argparse.ArgumentParser()
parser.add_argument("element", help="the status bar element to generate", default="all", type=str)
args = parser.parse_args()

if args.element == 'all':
    print(f' {light()}| {volume()} | {battery()} | {date_time()} ')
else:
    print(eval(f'{args.element}()'))


