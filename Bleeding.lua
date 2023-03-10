Timer = 60
Regen = 30
function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
	if ReadShort(0x6877DA) == 0 and ReadByte(0x24AA5B6) > 0 then
		Timer = Timer - 1
	elseif ReadShort(0x6877DA) == 0 and ReadByte(0x24AA5B6) == 0 then
		Regen = Regen - 1
	end
	if ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) > 1 and ReadByte(Slot1+0x0) <= 20 then
		WriteByte(Slot1+0x0, ReadByte(Slot1+0x0) - 1)
		Timer = 120
	elseif ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) > 1 and ReadByte(Slot1+0x0) <= 40 then
		WriteByte(Slot1+0x0, ReadByte(Slot1+0x0) - 1)
		Timer = 90
	elseif ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) > 1 and ReadByte(Slot1+0x0) <= 60 then
		WriteByte(Slot1+0x0, ReadByte(Slot1+0x0) - 1)
		Timer = 60
	elseif ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) > 1 and ReadByte(Slot1+0x0) > 60 then
		WriteByte(Slot1+0x0, ReadByte(Slot1+0x0) - 1)
		Timer = 30
	elseif ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) == 1 and ReadByte(Slot1+0x180) > 0 then
		WriteByte(Slot1+0x180, ReadByte(Slot1+0x180) - 1)
		Timer = 20
	elseif ReadByte(0x24AA5B6) > 0 and ReadShort(0x6877DA) == 0 and Timer <= 0 and ReadByte(Slot1+0x0) == 1 and ReadByte(Slot1+0x180) == 0 and ReadByte(Slot1+0x1B0) > 0 then
		WriteByte(Slot1+0x1B0, ReadByte(Slot1+0x1B0) - 1)
		Timer = 5
	elseif ReadByte(Slot1+0x1B0) == 0 and Timer <= 0 and ReadByte(Slot1+0x1B1) > 0 then
		WriteByte(Slot1+0x1B1, ReadByte(Slot1+0x1B1) - 1)
		WriteByte(Slot1+0x1B0, 100)
	elseif ReadShort(0x6877DA) == 0 and ReadByte(0x24AA5B6) == 0 and ReadByte(Slot1+0x0) < ReadByte(Slot1+0x4) and Regen <= 0 then
		WriteByte(Slot1+0x0, ReadByte(Slot1+0x0) + 1)
		Regen = 30
	end
end
