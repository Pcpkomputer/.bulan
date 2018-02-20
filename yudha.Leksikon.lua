script_name="Leksikon"
script_description = "Skrip GUI untuk melakukan eksekusi CLI aegiPy"
script_author      = "Padang Perwira Yudha"
script_version     = "1.2.0"
script_namespace="yudha.Leksikon"


local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
   script_version="1.2.0"
    depRec=DependencyControl{feed="https://raw.githubusercontent.com/Pcpkomputer/.bulan/master/DependencyControl.json"}
end


function serang(subs,sel)
	tampung1=res.wikipedia
	tampung2=res.kbbi
	tampung3=res.sinonim
	tampung4=res.antonim
------------------------------------------------------------------

	if res["wikicek"] then
	skrup="wikipedia.py -k "..tampung1.."\n@pause"
	crot=vpath.."temp.bat"
	local pl0x=io.open(vpath.."temp.bat","w")
	pl0x:write(skrup)
	pl0x:close()
	progres(subs,sel)
------------------------------------------------------------------
	elseif res["kbbicek"] then
	skrup="kbbi5.py -k "..tampung2.."\n@pause"
	crot=vpath.."temp.bat"
	local pl0x=io.open(vpath.."temp.bat","w")
	pl0x:write(skrup)
	pl0x:close()
	progres(subs,sel)
------------------------------------------------------------------
	elseif res["sinonimcek"] then
	skrup="sinonim.py -k "..tampung3.."\n@pause"
	crot=vpath.."temp.bat"
	local pl0x=io.open(vpath.."temp.bat","w")
	pl0x:write(skrup)
	pl0x:close()
	progres(subs,sel)
-----------------------------------------------------------------
	elseif res["antonimcek"] then
	skrup="antonim.py -k "..tampung4.."\n@pause"
	crot=vpath.."temp.bat"
	local pl0x=io.open(vpath.."temp.bat","w")
	pl0x:write(skrup)
	pl0x:close()
	progres(subs,sel)
	else
	main(subs,sel)
	end
	--- END FUNGSI ---
	end
	------------------

function main(subs,sel)
	ADD=aegisub.dialog.display
	ADP=aegisub.decode_path
	ADO=aegisub.dialog.open
	vpath="D:\\"

	GUI=
{
	{x=0,y=0,width=1,height=1,class="label",label="Versi 1.2.0",},
	{x=1,y=0,width=1,height=1,class="label",label="[  Spasi = %%20  ]",},
	{x=0,y=1,width=1,height=1,class="checkbox",name="wikicek",label="Wikipedia",},
	{x=1,y=1,width=1,height=1,class="edit",name="wikipedia",},
	{x=0,y=2,width=1,height=1,class="checkbox",name="kbbicek",label="KBBI V",},
	{x=1,y=2,width=1,height=1,class="edit",name="kbbi",},
	{x=0,y=3,width=1,height=1,class="checkbox",name="sinonimcek",label="Sinonim",},
	{x=1,y=3,width=1,height=1,class="edit",name="sinonim",},
	{x=0,y=4,width=1,height=1,class="checkbox",name="antonimcek",label="Antonim",},
	{x=1,y=4,width=1,height=1,class="edit",name="antonim",},

}
P,res=ADD(GUI,
{"Proses", "Kembali"})
if P=="Proses" then serang(subs,sel) end
if P=="Kembali" then aegisub.cancel() end
end


function progres(subs,sel)
	aegisub.progress.title("Memproses...")
	crot=crot:gsub("%=","^=")
	os.execute(crot)
	main(subs, sel)
	end
--

if haveDepCtrl then depRec:registerMacro(main) else aegisub.register_macro(script_name,script_description,main) end

