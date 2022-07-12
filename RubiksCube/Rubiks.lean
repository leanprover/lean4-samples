import Lean
open Lean Elab Widget

-- [todo] put this in core?
elab (name := includeStr) "include_str " str:str : term => do
  let str := str.getString
  let ctx ← readThe Lean.Core.Context
  let srcPath := System.FilePath.mk ctx.fileName
  let some srcDir := srcPath.parent | throwError "{srcPath} not in a valid directory"
  let path := srcDir / str
  Lean.mkStrLit <$> IO.FS.readFile path

@[widget]
def rubiks : UserWidgetDefinition := {
  name := "Rubik's cube"
  javascript:= include_str "./widget/dist/rubiks.js"
}

structure RubiksProps where
  seq : Array String := #[]
  deriving ToJson, FromJson, Inhabited

def eg : RubiksProps := {seq := #["L", "L", "D⁻¹", "U⁻¹", "L", "D", "D", "L", "U⁻¹", "R", "D", "F", "F", "D"]}

#widget rubiks (toJson eg)

