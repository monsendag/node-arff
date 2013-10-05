


// start grammar

start
  = arff

arff
  = __ header:header __ data:data __ { return {'header':header, 'data': data } }

header
  = relation:relation __ attributes:attribute+
    { return  {'relation':  relation, attributes: attributes}  }

relation
  = "@relation"i __ relation:string { return relation; }

attribute
  = "@attribute"i __ attribute:string __ type:datatype __
    { var o = {};
      o[attribute] = type;
      return o; }

datatype
  = "numeric"i
  / "integer"i
  / "real"i
  / "date" (string)?
  / "string"i
  / nominal

nominal
  = [a-zA-Z\-,{}]+

data
  = "@data"i __ lines:line* __ { return lines; }

line
  =  value:string ("," value:string)* __ { return value; }

string
  = str:[a-zA-Z0-9\.\-]+ { return str.join(""); }

__
  = ( _ / EOL / comment )*

_
  = [\t\v\f \u00A0\uFEFF] 

EOL 
  = [\n\r] 

comment 
  = "%" (!EOL .)* EOL

                

