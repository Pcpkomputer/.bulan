script_name="Silih Otomatis"
script_description = "Melakukan aksi silih pada dialog"
script_author      = "Padang Perwira Yudha"
script_version     = "1.1.1"
script_namespace="yudha.SilihOtomatis"

local haveDepCtrl,DependencyControl,depRec=pcall(require,"l0.DependencyControl")
if haveDepCtrl then
    script_version="1.1.0"
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

function silih_otomatis(subs, selected, active)
  silih("*", subs)
  aegisub.set_undo_point("script_name")
end

if haveDepCtrl then depRec:registerMacro(silih_otomatis) else aegisub.register_macro(script_name,script_description,silih_otomatis) end


