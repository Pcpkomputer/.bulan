script_name="Leksikon"
script_description = "Skrip GUI untuk melakukan eksekusi CLI aegiPy"
script_author      = "Padang Perwira Yudha"
script_version     = "1.0.0"
script_namespace="yudha.Leksikon"


local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
   script_version="1.0.0"
    depRec=DependencyControl{feed="https://raw.githubusercontent.com/Pcpkomputer/.bulan/master/DependencyControl.json"}
end

function kbbi(subs,sel)
skrup="kbbi5.py -k "..res.kbbi.."\n@pause"
crot=vpath.."temp.bat"
local pl0x=io.open(vpath.."temp.bat","w")
pl0x:write(skrup)
pl0x:close()
---
aegisub.progress.title("Memproses...")
crot=crot:gsub("%=","^=")
os.execute(crot)
main(subs, sel)
end
---

function sinonim(subs,sel)
skrup="sinonim.py -k "..res.sinonim.."\n@pause"
crot=vpath.."temp.bat"
local pl0x=io.open(vpath.."temp.bat","w")
pl0x:write(skrup)
pl0x:close()
---
aegisub.progress.title("Memproses...")
crot=crot:gsub("%=","^=")
os.execute(crot)
main(subs, sel)
end
----

function main(subs,sel)
	ADD=aegisub.dialog.display
	ADP=aegisub.decode_path
	ADO=aegisub.dialog.open
	vpath="D:\\"

	GUI=
{
	{x=0,y=0,width=1,height=1,class="label",label="Versi 1.0.0",},
	{x=0,y=1,width=1,height=1,class="label",label="KBBI V:",},
	{x=1,y=1,width=16,height=1,class="edit",name="kbbi",},
	{x=0,y=2,width=1,height=1,class="label",label="Sinonim:",},
	{x=1,y=2,width=16,height=1,class="edit",name="sinonim",},

}
P,res=ADD(GUI,
{"KBBI V","Sinonim","Kembali"})
if P=="KBBI V" then kbbi(subs,sel) end
if P=="Sinonim" then sinonim(subs,sel) end
if P=="Kembali" then aegisub.cancel() end
end
--

if haveDepCtrl then depRec:registerMacro(main) else aegisub.register_macro(script_name,script_description,main) end

