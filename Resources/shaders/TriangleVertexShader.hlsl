#include "TriangleShaderHeader.hlsli"

VSOutput main(float4 pos : POSITION, float scale : TEXCOORD, float4 color : COLOR, float4 normal : NORMAL)
{
	VSOutput output; // ピクセルシェーダーに渡す値
	output.pos = pos;
	output.scale = scale;
	output.color = color;
	output.normal = normal;
	return output;
}