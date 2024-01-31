@echo off

set Path=%Path%;C:\Program Files (x86)\Embarcadero\Studio\22.0\bin
Brcc32 -r -32 .\resources.rc

Pause
