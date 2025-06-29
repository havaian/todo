import { Context, Markup } from 'telegraf'

export function sendLogin(ctx: Context) {
  return ctx.reply(
    ctx.dbuser && ctx.i18n
      ? ctx.i18n.t('login')
      : `Please, login to todomaster.com with the button below first and then come back.

Пожалуйста, зайдите на todomaster.com при помощи кнопки ниже, а потом возвращайтесь.`,
    {
      reply_markup: Markup.inlineKeyboard(loginKeyboard()),
    }
  )
}

function loginKeyboard(): any {
  return [
    {
      text: 'Todomaster login',
      url: process.env.DEBUG ? 'https://todomaster.com' : undefined,
      login_url: process.env.DEBUG
        ? undefined
        : {
            url: 'https://todomaster.com',
          },
    },
  ]
}
