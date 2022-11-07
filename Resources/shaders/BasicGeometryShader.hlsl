
#include "BasicShaderHeader.hlsli"

//四角形の頂点数
static const uint vnum = 4;

//センターからのオフセット
static const float4 offset_array[vnum] =
{
	float4(-0.5f,-0.5f,0,0),//左下
	float4(-0.5f,+0.5f,0,0),//左上
	float4(+0.5f,-0.5f,0,0),//右下
	float4(+0.5f,+0.5f,0,0),//右上
};

//uv用
static const float2 uv_array[vnum] =
{
	float2(0,1),//左下
	float2(0,0),//左上
	float2(1,1),//右下
	float2(1,0),//右上
};

//(32bit(float)を最大1024個)
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1] : SV_POSITION, //入力プリミティブの種類
	inout TriangleStream< GSOutput > output//出力ストリーム型
)
{
	GSOutput element;
	//四点分
	for (int i = 0; i < vnum; i++)
	{
		//ワールド座標ベースで、ずらす
		element.svpos = input[0].pos + offset_array[i];
		//ビュー射影変換
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		output.Append(element);
	}
}