script_name="Unnecesarry Chapter Tools"
script_description = "yeah this script is literally unnecessary"
script_author      = "Padang Perwira Yudha"
script_version     = "2.0.0"
script_namespace="yudha.UnnecessaryChapter"

local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
    script_version="2.0.0"
    depRec=DependencyControl{feed="https://raw.githubusercontent.com/Pcpkomputer/.bulan/master/DependencyControl.json"}
end

--	SETTINGS	--

default_marker="actor"			-- options: "actor","effect","comment"
default_chapter_name="comment"		-- options: "comment","effect"
default_save_name="script"		-- options: "script","video"

--	--	--	--

require "clipboard"

function chopters(subs, sel)
	euid=0
	chptrs={}
    for i = 1, #subs do
      if subs[i].class == "info" then
	if subs[i].key=="Video File" then videoname=subs[i].value  videoname=videoname:gsub("%.mkv","") end
      end

      if subs[i].class == "dialogue" then
        local line = subs[i]
	local text=subs[i].text
	local actor=line.actor
	local effect=line.effect
	local start=line.start_time
	if text:match("{chapter}") or text:match("{chptr}") or text:match("{chap}") then comment="chapter" else comment="" end
	if res.marker=="actor" then marker=actor end
	if res.marker=="effect" then marker=effect end
	if res.marker=="comment" then marker=comment end

	    if marker=="chapter" or marker=="chptr" or marker=="chap" then
		if res.nam=="comment" then
		name=text:match("^{([^}]*)}")
		name=name:gsub(" [Ff]irst [Ff]rame","")
		name=name:gsub(" [Ss]tart","")
		name=name:gsub("part a","Part A")
		name=name:gsub("part b","Part B")
		name=name:gsub("preview","Preview")
		else
		name=effect
		end

		lineid=start

		timecode=math.floor(start/1000)
		tc1=math.floor(timecode/60)
		tc2=timecode%60
		tc3=start%1000
		tc4="00"
		if tc2==60 then tc2=0 tc1=tc1+1 end
		if tc1>119 then tc1=tc1-120 tc4="02" end
		if tc1>59 then tc1=tc1-60 tc4="01" end
		if tc1<10 then tc1="0"..tc1 end
		if tc2<10 then tc2="0"..tc2 end
		if tc3<100 then tc3="0"..tc3 end
		linetime=tc4..":"..tc1..":"..tc2.."."..tc3

		cur_chptr={name=name,id=lineid,tim=linetime}
		table.insert(chptrs,cur_chptr)

	    end
	if line.style=="Default" then euid=euid+text:len() end
      end
    end

	insert_chapters=""


    for c=1,#chptrs do
	local ch=chptrs[c]

	ch_uid=ch.id
	ch_name=ch.name
	ch_time=ch.tim

	chapter="    <ChapterAtom>\n      <ChapterUID>"..ch_uid.."</ChapterUID>\n      <ChapterFlagHidden>0</ChapterFlagHidden>\n      <ChapterFlagEnabled>1</ChapterFlagEnabled>\n      <ChapterDisplay>\n        <ChapterString>"..ch_name.."</ChapterString>\n        <ChapterLanguage>eng</ChapterLanguage>\n      </ChapterDisplay>\n      <ChapterTimeStart>"..ch_time.."</ChapterTimeStart>\n    </ChapterAtom>\n"

	insert_chapters=insert_chapters..chapter
    end

	chapters="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n<Chapters>\n  <EditionEntry>\n    <EditionFlagHidden>0</EditionFlagHidden>\n    <EditionFlagDefault>0</EditionFlagDefault>\n    <EditionUID>"..euid.."</EditionUID>\n"..insert_chapters.."  </EditionEntry>\n</Chapters>"

    chdialog=
	{{x=0,y=0,width=35,height=1,class="label",label="Berkas xml:"},
	{x=0,y=1,width=35,height=20,class="textbox",name="copytext",value=chapters},
	{x=0,y=21,width=35,height=1,class="label",label="Berkas akan di simpan di direktori yang sama dengan .ass"},}

    pressed,reslt=aegisub.dialog.display(chdialog,{"Simpan File XML","Batalkan","Salin ke Clipboard",},{cancel='Batalkan'})
    if pressed=="Salin ke Clipboard" then    clipboard.set(chapters) end
    if pressed=="Simpan File XML" then
	scriptpath=aegisub.decode_path("?script")
	scriptname=aegisub.file_name()
	scriptname=scriptname:gsub("%.ass","")
	if res.sav=="script" then filename=scriptname else filename=videoname end
	local file = io.open(scriptpath.."\\"..filename..".xml", "w")
	file:write(chapters)
	file:close()
    end
end

function seleksi(subs, sel)
    for x, i in ipairs(sel) do
        line=subs[i]
        text=line.text
	    text=text
		:gsub("\\1","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Prolog}")
		:gsub("\\2","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Lagu Pembuka}")
		:gsub("\\3","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Bagian 1}")
		:gsub("\\4","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Bagian 2}")
		:gsub("\\5","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Lagu Penutup}")
		:gsub("\\6","{["..res.grup.. "] " ..res.nama.. " - " ..res.episode..": Cuplikan}")
		line.actor="chapter"
		line.effect="chapter"
		line.text=text
		subs[i]=line
		end
		return sel
		end

function main(subs,sel)
ADD=aegisub.dialog.display
GUI=
{
	{x=0,y=0,width=1,height=1,class="label",label="Documentation:",},
	{x=1,y=0,width=1,height=1,class="label",label="/github/pcpkomputer/.bulan",},
	{x=3,y=0,width=1,height=1,class="label",label="Unnecessary Chapter Tools v2.0.0",},
    {x=0,y=1,width=1,height=1,class="label",label="Nama Grup :",},
    {x=1,y=1,width=1,height=1,class="edit",name="grup",},
	{x=0,y=2,width=1,height=1,class="label",label="Nama Acara :",},
    {x=1,y=2,width=1,height=1,class="edit",name="nama",},
	{x=0,y=3,width=1,height=1,class="label",label="Episode :",},
    {x=1,y=3,width=1,height=1,class="edit",name="episode",},
	{x=2,y=1,width=1,height=1,class="label",label="Gunakan sbg penanda chapter:"},
	{x=3,y=1,width=1,height=1,class="dropdown",name="marker",items={"actor","effect","comment"},value=default_marker},
	{x=2,y=2,width=1,height=1,class="label",label="Dapatkan nama chapter dari:"},
	{x=3,y=2,width=1,height=1,class="dropdown",name="nam",items={"comment","effect"},value=default_chapter_name},
	{x=2,y=3,width=1,height=1,class="label",label="Sumber nama file .xml:     "},
	{x=3,y=3,width=1,height=1,class="dropdown",name="sav",items={"script","video"},value=default_save_name},

}
P,res=ADD(GUI,
{"Terapkan", "Proses Chapter","Kembali"},{ok='Proses Chapter',cancel='Kembali'})
if P=="Kembali" then    aegisub.cancel() end
if P=="Proses Chapter" then   chopters(subs, sel) end
if P=="Terapkan" then seleksi(subs, sel) end
    return sel,act
end

function unnecessary(subs, sel)
    main(subs,sel)
    aegisub.set_undo_point(script_name)
    return sel
end


if haveDepCtrl then depRec:registerMacro(unnecessary) else aegisub.register_macro(script_name,script_description,unnecessary) end


