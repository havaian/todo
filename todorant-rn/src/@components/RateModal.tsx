import { Alert, Linking, Platform } from 'react-native'
import { Observer } from 'mobx-react'
import { sendFeedback } from '@utils/rest'
import { sharedColors } from '@utils/sharedColors'
import { sharedSessionStore } from '@stores/SessionStore'
import { translate } from '@utils/i18n'
import RateModalExternal from '@tasumaniadiabori/react-native-store-rating'
import React, { memo } from 'react'

export const RateModal = memo(() => {
  return (
    <Observer>
      {() => {
        return (
          <RateModalExternal
            rateBtnText={translate('rate')}
            cancelBtnText={translate('cancel')}
            sendBtnText={translate('send')}
            commentPlaceholderText={translate('rateCommentPlaceholder')}
            emptyCommentErrorMessage={translate('rateCommentEmptyError')}
            iTunesStoreUrl="itms-apps://itunes.apple.com/app/1482078243"
            playStoreUrl="market://details?id=com.todomaster"
            isModalOpen={sharedSessionStore.needsToRequestRate}
            storeRedirectThreshold={4}
            modalTitle={translate('rateTitle')}
            starLabels={[
              translate('starTerrible'),
              translate('starBad'),
              translate('starOkay'),
              translate('starGood'),
              translate('starGreat'),
            ]}
            style={{}}
            // eslint-disable-next-line @typescript-eslint/no-empty-function
            onStarSelected={() => {}}
            onClosed={() => {
              sharedSessionStore.askedToRate = true
            }}
            sendContactUsForm={(state) => {
              sharedSessionStore.askedToRate = true
              if (!sharedSessionStore.user?.token) {
                return
              }
              sendFeedback(state, sharedSessionStore.user?.token)
            }}
            styles={{
              modalContainer: { backgroundColor: sharedColors.backgroundColor },
              title: { color: sharedColors.textColor },
              button: { backgroundColor: sharedColors.primaryColor },
              buttonText: { color: sharedColors.backgroundColor },
              buttonCancel: {
                borderColor: sharedColors.textColor,
                backgroundColor: sharedColors.backgroundColor,
              },
              buttonCancelText: { color: sharedColors.textColor },
              ...({ textBox: { color: sharedColors.textColor } } as any),
              placeholderTextColor: sharedColors.placeholderColor,
              errorText: { color: 'tomato' },
            }}
            onRated={() => {
              setTimeout(() => {
                Alert.alert(
                  '',
                  translate(
                    Platform.OS === 'android'
                      ? 'rateSolicitationGoogle'
                      : 'rateSolicitationApple'
                  ),
                  [
                    {
                      text: translate('cancel'),
                      style: 'cancel',
                      onPress: () => {
                        sharedSessionStore.askedToRate = true
                      },
                    },
                    {
                      text: translate('rateButton'),
                      onPress: () => {
                        Linking.openURL(
                          Platform.OS === 'android'
                            ? 'market://details?id=com.todomaster'
                            : 'itms-apps://itunes.apple.com/app/1482078243'
                        )
                        sharedSessionStore.askedToRate = true
                      },
                    },
                  ]
                )
              }, 100)
            }}
          />
        )
      }}
    </Observer>
  )
})
