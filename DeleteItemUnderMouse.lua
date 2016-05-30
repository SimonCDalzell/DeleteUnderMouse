-- When run, checks position of media item under mouse and deletes all items that are at the same position. Very useful for quickly editing sampling sessions.
-- Created by Simon Dalzell. 5-30-2016. I have no idea how to maintain a git repo.

function Msg(param)
  reaper.ShowConsoleMsg(tostring(param).."\n")
end

function Main()
	reaper.Undo_BeginBlock()
	mouse_item, position = reaper.BR_ItemAtMouseCursor()
	if mouse_item then
		count_items = reaper.CountMediaItems(0)
		mouse_item_pos = reaper.GetMediaItemInfo_Value(mouse_item, "D_POSITION")
		mouse_item_track = reaper.GetMediaItem_Track(mouse_item)

		for i = 0 , (count_items - 2) do
			item = reaper.GetMediaItem(0, i)
			if item ~= mouse_item then
				item_track = reaper.GetMediaItem_Track(item)
				item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
				
				if item_pos == mouse_item_pos then
					reaper.DeleteTrackMediaItem(item_track, item)
				end
			end
		end
		reaper.DeleteTrackMediaItem(mouse_item_track, mouse_item)
		reaper.UpdateArrange()
	end
	reaper.Undo_EndBlock("Delete groups under mouse cursor", -1)
end

Main()