script_name="Silih Otomatis"
script_description = "Melakukan aksi silih pada dialog"
script_author      = "Padang Perwira Yudha"
script_version     = "2.0.0"
script_namespace="yudha.SilihOtomatis"

local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
    script_version="2.0.0"
    depRec=DependencyControl{feed="https://raw.githubusercontent.com/Pcpkomputer/.bulan/master/DependencyControl.json"}
end

function silih(bintang, subs)
	local pola = "{%"..bintang.."}([^{]*){%"..bintang.."([^%"..bintang.."]?[^}]*)}"
	local silih = "{%"..bintang.."}%2{%"..bintang.."%1}"

for i=1, #subs do
	local dialog = subs[i]

	if dialog.class == "dialogue" then

			local style = dialog.style
			local efek = dialog.effect
			local proses = false

	  if style:match("Default") then proses = true end
      if style:match("Miring") then proses = true end
      if style:match("Dialog") then proses = true end


		 if proses then

			dialog.text = dialog.text

		   -- Mindah "{*}Padang-kun{*Mas Padang}" ke "{*}Mas Padang{*Padang-kun}"
          :gsub(pola, silih)

           end

      subs[i] = dialog

    end

  end

end

function bintang(subs, selected, active)
  silih("*", subs)
  aegisub.set_undo_point("script_name")
end


function add(subs, selected, active)
  silih("@", subs)
  aegisub.set_undo_point("script_name")
end


function pagar(subs, selected, active)
  silih("#", subs)
  aegisub.set_undo_point("script_name")
end


function dollar(subs, selected, active)
  silih("$", subs)
  aegisub.set_undo_point("script_name")
end


function persen(subs, selected, active)
  silih("%", subs)
  aegisub.set_undo_point("script_name")
end

function silih_main(subs, sel)
if res["cek1"] then bintang(subs, selected, active) end
if res["cek2"] then add(subs, selected, active) end
if res["cek3"] then pagar(subs, selected, active) end
if res["cek4"] then dollar(subs, selected, active) end
if res["cek5"] then persen(subs, selected, active) end

end

function uwu(subs)
			for i=1,#subs do
			if subs[i].class=="dialogue" then
            line=subs[i]
            text=subs[i].text
			if res["la1"] then
			text=text:gsub(res.ed1,"{*}"..res.ed1.."{*"..res.ed1go.."}") end
			if res["la2"] then
			text=text:gsub(res.ed2,"{*}"..res.ed2.."{*"..res.ed2go.."}") end
			if res["la3"] then
			text=text:gsub(res.ed3,"{*}"..res.ed3.."{*"..res.ed3go.."}") end
			if res["la4"] then
			text=text:gsub(res.ed4,"{*}"..res.ed4.."{*"..res.ed4go.."}") end
			if res["la5"] then
			text=text:gsub(res.ed5,"{*}"..res.ed5.."{*"..res.ed5go.."}") end
			line.text=text
			subs[i]=line
			end
			end
			end


function owo(subs, sel)
			for x, i in ipairs(sel) do
			line=subs[i]
			text=line.text
			if res["la1"] then
			text=text:gsub(res.ed1,"{*}"..res.ed1.."{*"..res.ed1go.."}") end
			if res["la2"] then
			text=text:gsub(res.ed2,"{*}"..res.ed2.."{*"..res.ed2go.."}") end
			if res["la3"] then
			text=text:gsub(res.ed3,"{*}"..res.ed3.."{*"..res.ed3go.."}") end
			if res["la4"] then
			text=text:gsub(res.ed4,"{*}"..res.ed4.."{*"..res.ed4go.."}") end
			if res["la5"] then
			text=text:gsub(res.ed5,"{*}"..res.ed5.."{*"..res.ed5go.."}") end
			line.text=text
			subs[i]=line
			end
			return sel
			end

function main(subs,sel)
ADD=aegisub.dialog.display
GUI=
{
	{x=0,y=0,width=1,height=1,class="label",label="[v2.0.0]",},
	{x=1,y=0,width=1,height=1,class="label",label="[//]",},
	{x=2,y=0,width=1,height=1,class="label",label="[Kalimat Awal]",},
	{x=3,y=0,width=1,height=1,class="label",label="[//]",},
	{x=4,y=0,width=1,height=1,class="label",label="[Kalimat Akhir]",},
	{x=0,y=1,width=1,height=1,class="checkbox",name="cek1",label="*",},
	{x=0,y=2,width=1,height=1,class="checkbox",name="cek2",label="@",},
	{x=0,y=3,width=1,height=1,class="checkbox",name="cek3",label="#",},
	{x=0,y=4,width=1,height=1,class="checkbox",name="cek4",label="$",},
	{x=0,y=5,width=1,height=1,class="checkbox",name="cek5",label="%",},
	--
	{x=1,y=1,width=1,height=1,class="checkbox",name="la1",},
	{x=1,y=2,width=1,height=1,class="checkbox",name="la2",},
	{x=1,y=3,width=1,height=1,class="checkbox",name="la3",},
	{x=1,y=4,width=1,height=1,class="checkbox",name="la4",},
	{x=1,y=5,width=1,height=1,class="checkbox",name="la5",},
	--
	{x=2,y=1,width=1,height=1,class="edit",name="ed1",},
	{x=3,y=1,width=1,height=1,class="label",label=">",},
	{x=4,y=1,width=6,height=1,class="edit",name="ed1go",},

	{x=2,y=2,width=1,height=1,class="edit",name="ed2",},
	{x=3,y=2,width=1,height=1,class="label",label=">",},
	{x=4,y=2,width=6,height=1,class="edit",name="ed2go",},

	{x=2,y=3,width=1,height=1,class="edit",name="ed3",},
	{x=3,y=3,width=1,height=1,class="label",label=">",},
	{x=4,y=3,width=6,height=1,class="edit",name="ed3go",},

	{x=2,y=4,width=1,height=1,class="edit",name="ed4",},
	{x=3,y=4,width=1,height=1,class="label",label=">",},
	{x=4,y=4,width=6,height=1,class="edit",name="ed4go",},

	{x=2,y=5,width=1,height=1,class="edit",name="ed5",},
	{x=3,y=5,width=1,height=1,class="label",label=">",},
	{x=4,y=5,width=6,height=1,class="edit",name="ed5go",},

	}

P,res=ADD(GUI,
{"Silih", "Seluruh","Sorot","Kembali"})
if P=="Seluruh" then    uwu(subs) end
if P=="Sorot" then    owo(subs, sel) end
if P=="Kembali" then    aegisub.cancel() end
if P=="Silih" then   silih_main(subs, sel) end

    return sel,act
end

function silih_otomatis(subs, sel)
main(subs, sel)
aegisub.set_undo_point(script_name)
return sel
end

if haveDepCtrl then depRec:registerMacro(main) else aegisub.register_macro(script_name,script_description,main) end

