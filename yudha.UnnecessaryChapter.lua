script_name="Unnecesarry Chapter Tools"
script_description = "yeah this script is literally unnecessary"
script_author      = "Padang Perwira Yudha"
script_version     = "1.0.0"
script_namespace="yudha.UnnecessaryChapter"

local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
    script_version="1.0.0"
    depRec=DependencyControl{feed="https://raw.githubusercontent.com/Pcpkomputer/.bulan/master/DependencyControl.json"}
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

function main(subs,sel,act)
ADD=aegisub.dialog.display
GUI=
{
	{x=0,y=0,width=1,height=1,class="label",label="Versi 1.0.0",},
    {x=0,y=1,width=1,height=1,class="label",label="Nama Grup :",},
    {x=1,y=1,width=1,height=1,class="edit",name="grup",},
	{x=0,y=2,width=1,height=1,class="label",label="Nama Acara :",},
    {x=1,y=2,width=1,height=1,class="edit",name="nama",},
	{x=0,y=3,width=1,height=1,class="label",label="Episode :",},
    {x=1,y=3,width=1,height=1,class="edit",name="episode",},
}
P,res=ADD(GUI,
{"Terapkan"})
if P=="Terapkan" then seleksi(subs, sel) end
aegisub.set_undo_point(script_name)
    return sel,act
end

if haveDepCtrl then depRec:registerMacro(main) else aegisub.register_macro(script_name,script_description,main) end


