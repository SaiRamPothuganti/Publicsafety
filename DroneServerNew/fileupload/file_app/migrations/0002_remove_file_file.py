# -*- coding: utf-8 -*-
# Generated by Django 1.11.21 on 2019-07-02 12:57
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('file_app', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='file',
            name='file',
        ),
    ]
