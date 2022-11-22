
#include "TriangleShaderHeader.hlsli"

//�l�p�`�̒��_��
static const uint vnum = 3;

static const float leftPos = -2.0f;
static const float rightPos = 2.0f;
static const float topPos = +2.0f;
static const float bottomPos = -2.0f;
static const float frontPos = -2.0f;
static const float backPos = +2.0f;

// �Z���^�[����̃I�t�Z�b�g�i���ʁj
static const float4 offset_array[vnum * 2] =
{
	float4(leftPos, bottomPos,frontPos,0),//����
	float4(leftPos,topPos,frontPos,0),//����
	float4(rightPos, bottomPos,frontPos,0),//�E��

	float4(rightPos,topPos,frontPos,0),//�E��
	float4(rightPos, bottomPos,frontPos,0),//�E��
	float4(leftPos,topPos,frontPos,0),//����
};
// �Z���^�[����̃I�t�Z�b�g�i���j
static const float4 offset_array2[vnum * 2] =
{
	float4(rightPos, bottomPos,backPos,0),//����
	float4(rightPos, topPos,backPos,0),//����
	float4(leftPos, bottomPos,backPos,0),//�E��

	float4(leftPos,topPos,backPos,0),//�E��
	float4(leftPos, bottomPos,backPos,0),//�E��
	float4(rightPos, topPos,backPos,0),//����
};
// �Z���^�[����̃I�t�Z�b�g�i��j
static const float4 offset_array3[vnum * 2] =
{
	float4(leftPos,topPos,frontPos,0),//����
	float4(leftPos,topPos,backPos,0),//����
	float4(rightPos, topPos,frontPos,0),//�E��

	float4(rightPos,topPos,backPos,0),//�E��
	float4(rightPos, topPos,frontPos,0),//�E��
	float4(leftPos,topPos,backPos,0),//����
};
// �Z���^�[����̃I�t�Z�b�g�i���j
static const float4 offset_array4[vnum * 2] =
{
	float4(rightPos, bottomPos,frontPos,0),//����
	float4(rightPos,bottomPos,backPos,0),//����
	float4(leftPos, bottomPos,frontPos,0),//�E��

	float4(leftPos,bottomPos,backPos,0),//�E��
	float4(leftPos, bottomPos,frontPos,0),//�E��
	float4(rightPos,bottomPos,backPos,0),//����
};
// �Z���^�[����̃I�t�Z�b�g�i���j
static const float4 offset_array5[vnum * 2] =
{
	float4(leftPos,bottomPos,backPos,0),//����
	float4(leftPos,topPos,backPos,0),//����
	float4(leftPos, bottomPos,frontPos,0),//�E��

	float4(leftPos, topPos,frontPos,0),//�E��
	float4(leftPos, bottomPos,frontPos,0),//�E��
	float4(leftPos,topPos,backPos,0),//����
};
// �Z���^�[����̃I�t�Z�b�g�i�E�j
static const float4 offset_array6[vnum * 2] =
{
	float4(rightPos, bottomPos,frontPos,0),//����
	float4(rightPos,topPos,frontPos,0),//����
	float4(rightPos, bottomPos,backPos,0),//�E��

	float4(rightPos,topPos,backPos,0),//�E��
	float4(rightPos, bottomPos,backPos,0),//�E��
	float4(rightPos,topPos,frontPos,0),//����
};



//uv�p
static const float2 uv_array[vnum] =
{
	float2(0,1),//����
	float2(0,0),//����
	float2(0,0),//����
};

//(32bit(float)���ő�1024��)
[maxvertexcount(vnum)]
void main(
	point VSOutput input[1] : SV_POSITION, //���̓v���~�e�B�u�̎��
	inout TriangleStream< GSOutput > output//�o�̓X�g���[���^
)
{

	//3�_��
	for (int i = 0; i < vnum; i++)
	{

		float4 offset = { 0,0,0,0 };

		//���ʂ̖ʂ̎�
		if (input[0].normal.b < 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array[i + 3] * input[0].scale;
			}
		}
		//���̖ʂ̎�
		else if (input[0].normal.b > 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array2[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array2[i + 3] * input[0].scale;
			}
		}
		//��̖ʂ̎�
		else if (input[0].normal.g > 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array3[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array3[i + 3] * input[0].scale;
			}
		}
		//���̖ʂ̎�
		else if (input[0].normal.g < 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array4[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array4[i + 3] * input[0].scale;
			}
		}
		//���̖ʂ̎�
		else if (input[0].normal.r < 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array5[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array5[i + 3] * input[0].scale;
			}
		}
		//�E�̖ʂ̎�
		else if (input[0].normal.r > 0)
		{
			//�E�����̎O�p
			if (input[0].normal.w >= 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array6[i] * input[0].scale;
			}
			//�����̎O�p
			else if (input[0].normal.w < 0)
			{
				//���S����̃I�t�Z�b�g���X�P�[�����O
				offset = offset_array6[i + 3] * input[0].scale;
			}
		}

		GSOutput element;
		//�I�t�Z�b�g�����炷�i���[���h���W�j
		element.svpos = input[0].pos + offset;

		//���[���h���W�x�[�X�ŁA���炷
		//element.svpos = input[0].pos + offset_array[i];
		//�r���[�ˉe�ϊ�
		element.svpos = mul(mat, element.svpos);
		element.uv = uv_array[i];
		element.color = input[0].color;
		output.Append(element);
	}
}