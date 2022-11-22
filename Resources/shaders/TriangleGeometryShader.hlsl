
#include "TriangleShaderHeader.hlsli"

//四角形の頂点数
static const uint vnum = 3;

static const float leftPos = -2.0f;
static const float rightPos = 2.0f;
static const float topPos = +2.0f;
static const float bottomPos = -2.0f;
static const float frontPos = -2.0f;
static const float backPos = +2.0f;

// センターからのオフセット（正面）
static const float4 offset_array[vnum * 2] =
{
	float4(leftPos, bottomPos,frontPos,0),//左下
	float4(leftPos,topPos,frontPos,0),//左上
	float4(rightPos, bottomPos,frontPos,0),//右下

	float4(rightPos,topPos,frontPos,0),//右上
	float4(rightPos, bottomPos,frontPos,0),//右下
	float4(leftPos,topPos,frontPos,0),//左上
};
// センターからのオフセット（奥）
static const float4 offset_array2[vnum * 2] =
{
	float4(rightPos, bottomPos,backPos,0),//左下
	float4(rightPos, topPos,backPos,0),//左上
	float4(leftPos, bottomPos,backPos,0),//右下

	float4(leftPos,topPos,backPos,0),//右上
	float4(leftPos, bottomPos,backPos,0),//右下
	float4(rightPos, topPos,backPos,0),//左上
};
// センターからのオフセット（上）
static const float4 offset_array3[vnum * 2] =
{
	float4(leftPos,topPos,frontPos,0),//左下
	float4(leftPos,topPos,backPos,0),//左上
	float4(rightPos, topPos,frontPos,0),//右下

	float4(rightPos,topPos,backPos,0),//右上
	float4(rightPos, topPos,frontPos,0),//右下
	float4(leftPos,topPos,backPos,0),//左上
};
// センターからのオフセット（下）
static const float4 offset_array4[vnum * 2] =
{
	float4(rightPos, bottomPos,frontPos,0),//左下
	float4(rightPos,bottomPos,backPos,0),//左上
	float4(leftPos, bottomPos,frontPos,0),//右下

	float4(leftPos,bottomPos,backPos,0),//右上
	float4(leftPos, bottomPos,frontPos,0),//右下
	float4(rightPos,bottomPos,backPos,0),//左上
};
// センターからのオフセット（左）
static const float4 offset_array5[vnum * 2] =
{
	float4(leftPos,bottomPos,backPos,0),//左下
	float4(leftPos,topPos,backPos,0),//左上
	float4(leftPos, bottomPos,frontPos,0),//右下

	float4(leftPos, topPos,frontPos,0),//右上
	float4(leftPos, bottomPos,frontPos,0),//右下
	float4(leftPos,topPos,backPos,0),//左上
};
// センターからのオフセット（右）
static const float4 offset_array6[vnum * 2] =
{
	float4(rightPos, bottomPos,frontPos,0),//左下
	float4(rightPos,topPos,frontPos,0),//左上
	float4(rightPos, bottomPos,backPos,0),//右下

	float4(rightPos,topPos,backPos,0),//右上
	float4(rightPos, bottomPos,backPos,0),//右下
	float4(rightPos,topPos,frontPos,0),//左上
};



//uv用
static const float2 uv_array[vnum] =
{
	float2(0,1),//左下
	float2(0,0),//左上
	float2(0,0),//左上
};

//(32bit(float)を最大1024個)
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1] : SV_POSITION, //入力プリミティブの種類
	inout TriangleStream< GSOutput > output//出力ストリーム型
)
{

	//3点分
	for (int i = 0; i < vnum; i++)
	{

		float4 offset = { 0,0,0,0 };

		//正面の面の時
		if (input[0].normal.b < 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array[i + 3] * input[0].scale;
			}
		}
		//奥の面の時
		else if (input[0].normal.b > 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array2[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array2[i + 3] * input[0].scale;
			}
		}
		//上の面の時
		else if (input[0].normal.g > 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array3[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array3[i + 3] * input[0].scale;
			}
		}
		//下の面の時
		else if (input[0].normal.g < 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array4[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array4[i + 3] * input[0].scale;
			}
		}
		//左の面の時
		else if (input[0].normal.r < 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array5[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array5[i + 3] * input[0].scale;
			}
		}
		//右の面の時
		else if (input[0].normal.r > 0)
		{
			//右半分の三角
			if (input[0].normal.w >= 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array6[i] * input[0].scale;
			}
			//半分の三角
			else if (input[0].normal.w < 0)
			{
				//中心からのオフセットをスケーリング
				offset = offset_array6[i + 3] * input[0].scale;
			}
		}

		GSOutput element;
		//オフセット分ずらす（ワールド座標）
		element.svpos = input[0].pos + offset;

		//ワールド座標ベースで、ずらす
		//element.svpos = input[0].pos + offset_array[i];
		//ビュー射影変換
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		element.color = input[0].color;
		output.Append(element);
	}
}